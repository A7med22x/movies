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
       
     } throw RemoteException(message ?? 'Failed to Register');
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
    }  catch (e) {
      String? message;
     if (e is FirebaseAuthException) {
      message = e.message;
       
     } throw RemoteException(message ?? 'Failed to Login');
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
}
