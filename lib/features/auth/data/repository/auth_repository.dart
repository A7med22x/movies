import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/errors/exceptions.dart';
import 'package:movies/core/errors/failure.dart';
import 'package:movies/features/auth/data/data_source/auth_shared_pref_local_data_source.dart';
import 'package:movies/features/auth/data/data_source/auth_data_source.dart';
import 'package:movies/features/auth/data/models/user_model.dart';

@singleton
class AuthRepository {
  final AuthDataSource dataSource;
  final AuthSharedPrefLocalDataSource _localDataSource;

  AuthRepository(this.dataSource, this._localDataSource);

  Future<Either<Failure, UserModel>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
  }) async {
    try {
      final user = await dataSource.register(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        phoneNumber: phoneNumber,
      );
      await _localDataSource.saveUserId(user.id);
      return Right(user);
    } on RemoteException catch (exception) {
      return Left(Failure(exception.message));
    }
  }

  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await dataSource.login(email: email, password: password);
      await _localDataSource.saveUserId(user.id);
      return Right(user);
    } on RemoteException catch (exception) {
      return Left(Failure(exception.message));
    }
  }

  Future<Either<Failure, UserCredential?>> signInWithGoogle() async {
    try {
      final userCredential = await dataSource.signInWithGoogle();
      await _localDataSource.saveUserId(userCredential?.user?.uid ?? '');
      return Right(userCredential);
    } on RemoteException catch (exception) {
      return Left(Failure(exception.message));
    }
  }

  Future<Either<Failure, void>> addMovieToFavorites(String movieId) async {
    try {
      await dataSource.addMovieToFavorites(movieId);
      return const Right(null);
    } on RemoteException catch (e) {
      return Left(Failure(e.message));
    }
  }

  Future<Either<Failure, void>> removeMovieFromFavorites(String movieId) async {
    try {
      await dataSource.removeMovieFromFavorites(movieId);
      return const Right(null);
    } on RemoteException catch (e) {
      return Left(Failure(e.message));
    }
  }

  Future<Either<Failure, void>> addMovieToMoviesWatchedHistory(
    String movieId,
  ) async {
    try {
      await dataSource.addMovieToMoviesWatchedHistory(movieId);
      return const Right(null);
    } on RemoteException catch (e) {
      return Left(Failure(e.message));
    }
  }

  Future<Either<Failure, void>> logout() async {
    try {
      await dataSource.logout();
      await _localDataSource.saveUserId('');
      return const Right(null);
    } on RemoteException catch (e) {
      return Left(Failure(e.message));
    }
  }

  Future<Either<Failure, void>> deleteUser(String password) async {
    try {
      await dataSource.deleteUser(password);
      await _localDataSource.saveUserId('');
      return const Right(null);
    } on RemoteException catch (e) {
      return Left(Failure(e.message));
    }
  }

  Future<Either<Failure, void>> updateUser(UserModel user) async {
    try {
      await dataSource.updateUser(user);
      return const Right(null);
    } on RemoteException catch (e) {
      return Left(Failure(e.message));
    }
  }

  Future<Either<Failure, void>> resetPassword(String email) async {
    try {
      await dataSource.resetPassword(email);
      return const Right(null);
    } on RemoteException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
