import 'package:movies/features/auth/data/models/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {
  final UserModel user;
  RegisterSuccess(this.user);
}

class RegisterError extends AuthState {
  final String message; //عمري ما أحطها نالابل عشان هيا عايشة في حالة النجاح بس
  RegisterError(this.message);
}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final UserModel user;
  LoginSuccess(this.user);
}

class LoginError extends AuthState {
  final String message;
  LoginError(this.message);
}

class GoogleLoginLoading extends AuthState {}

class GoogleLoginSuccess extends AuthState {}

class GoogleLoginError extends AuthState {
  final String message;
  GoogleLoginError(this.message);
}

class UserUpdated extends AuthState {
  final UserModel user;

  UserUpdated(this.user);
}

class LogoutLoading extends AuthState {}

class LogoutSuccess extends AuthState {}

class LogoutError extends AuthState {
  final String message;
  LogoutError(this.message);
}

class DeleteUserLoading extends AuthState {}

class DeleteUserSuccess extends AuthState {}

class DeleteUserError extends AuthState {
  final String message;
  DeleteUserError(this.message);
}

class UpdateUserLoading extends AuthState {}

class UpdateUserSuccess extends AuthState {
  final UserModel user;

  UpdateUserSuccess(this.user);
}

class UpdateUserError extends AuthState {
  final String message;
  UpdateUserError(this.message);
}

class ResetPasswordLoading extends AuthState {}

class ResetPasswordSuccess extends AuthState {}

class ResetPasswordError extends AuthState {
  final String message;
  ResetPasswordError(this.message);
}
