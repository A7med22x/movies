import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/features/auth/data/models/user_model.dart';

abstract class AuthDataSource {
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
  });

  Future<UserModel> login({required String email, required String password});

  Future<UserCredential?> signInWithGoogle();

  Future<UserModel?> getUserById(String userId);

  Future<void> addMovieToFavorites(String movieId);

  Future<void> removeMovieFromFavorites(String movieId);

  Future<void> addMovieToMoviesWatchedHistory(String movieId);

  Future<void> logout();
  
  Future<void> deleteUser(String password);

  Future<void> updateUser(UserModel user);

  Future<void> resetPassword(String email);
}
