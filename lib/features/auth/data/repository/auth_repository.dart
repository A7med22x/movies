import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/errors/exceptions.dart';
import 'package:movies/core/errors/failure.dart';
import 'package:movies/features/auth/data/data_source/auth_data_source.dart';
import 'package:movies/features/auth/data/models/user_model.dart';

@singleton
class AuthRepository {
  AuthDataSource dataSource;
  AuthRepository(this.dataSource);

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
      return Right(user);
    } on RemoteException catch (exception) {
      return Left(Failure(exception.message));
    }
  }

  Future<Either<Failure,UserCredential?>> signInWithGoogle() async {
    try {
    final userCredential = await dataSource.signInWithGoogle();
    return Right(userCredential);
    } on RemoteException catch (exception) {
      return Left(Failure(exception.message));
    }
  }
}
