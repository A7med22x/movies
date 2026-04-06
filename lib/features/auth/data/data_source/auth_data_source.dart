import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/features/auth/data/models/user_model.dart';

abstract class AuthDataSource {
  CollectionReference<UserModel> getUsersCollection();
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
  });
  Future<UserModel> login({required String email, required String password});
  Future<UserCredential?> signInWithGoogle();
}
