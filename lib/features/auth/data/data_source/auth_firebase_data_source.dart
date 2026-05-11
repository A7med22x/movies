import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/errors/exceptions.dart';
import 'package:movies/features/auth/data/data_source/auth_data_source.dart';
import 'package:movies/features/auth/data/models/user_model.dart';

@Singleton(as: AuthDataSource)
class AuthFirebaseDataSource implements AuthDataSource {
  CollectionReference<UserModel> getUsersCollection() => FirebaseFirestore
      .instance
      .collection('users')
      .withConverter(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.tojson(),
      );

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
  }) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel user = UserModel(
        id: credential.user!.uid,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
      );
      CollectionReference<UserModel> usersCollection = getUsersCollection();
      await usersCollection
          .doc(user.id) //credential.user!.uid = user.id
          .set(user);
      return user;
    } catch (e) {
      String? message;
      if (e is FirebaseAuthException) {
        message = e.message;
      }
      throw RemoteException(message ?? 'Failed to Register');
    }
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      CollectionReference<UserModel> usersCollection = getUsersCollection();
      DocumentSnapshot<UserModel> documentSnapshot = await usersCollection
          .doc(credential.user!.uid)
          .get();
      return documentSnapshot.data()!;
    } catch (e) {
      String? message;
      if (e is FirebaseAuthException) {
        message = e.message;
      }
      throw RemoteException(message ?? 'Failed to Login');
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  @override
  Future<UserCredential?> signInWithGoogle() async {
    await _googleSignIn.initialize(
      serverClientId: dotenv.env['SERVER_CLIENT_ID'],
    );
    final GoogleSignInAccount result = await _googleSignIn.authenticate();
    final googleAuth = result.authentication;
    final credentials = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    final userC = FirebaseAuth.instance.signInWithCredential(credentials);
    return userC;
  }

  @override
  Future<UserModel?> getUserById(String userId) async {
    try {
      final doc = await getUsersCollection().doc(userId).get();
      return doc.data();
    } catch (e) {
      throw RemoteException('Failed to get user');
    }
  }

  @override
  Future<void> addMovieToFavorites(String movieId) async {
    await getUsersCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
          'favoriteMoviesIds': FieldValue.arrayUnion([movieId]),
        });
  }

  @override
  Future<void> removeMovieFromFavorites(String movieId) async {
    await getUsersCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
          'favoriteMoviesIds': FieldValue.arrayRemove([movieId]),
        });
  }

  @override
  Future<void> addMovieToMoviesWatchedHistory(String movieId) async {
    await getUsersCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
          'moviesWatchedHistoryIds': FieldValue.arrayUnion([movieId]),
        });
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> deleteUser(String password) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception("No user logged in");
    }
    try {
      // 1. Re-authenticate
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      await user.reauthenticateWithCredential(credential);

      // 2. Delete account
      await user.delete();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? e.code);
    }
  }

  @override
  Future<void> updateUser(UserModel user) async {
    await getUsersCollection().doc(user.id).update(user.tojson());
  }

  @override
  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
