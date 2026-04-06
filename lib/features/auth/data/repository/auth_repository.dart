import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/features/auth/data/data_source/auth_data_source.dart';
import 'package:movies/features/auth/data/models/user_model.dart';
@singleton
class AuthRepository {
  AuthDataSource dataSource;
  AuthRepository(this.dataSource);
  CollectionReference<UserModel> getUsersCollection() {
    return dataSource.getUsersCollection();
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
  }) async {
    return dataSource.register(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phoneNumber: phoneNumber,
    );
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    return dataSource.login(email: email, password: password);
  }

  Future<UserCredential?> signInWithGoogle() async {
    return dataSource.signInWithGoogle();
  }

  // Future<void> loginWithGoogle(BuildContext context) async {
  //   return dataSource.loginWithGoogle(context);
  // }
}
