abstract class AuthState {}

class AuthInitial extends AuthState {}

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterError extends AuthState {
  final String message; //عمري ما أحطها نالابل عشان هيا عايشة في حالة النجاح بس
  RegisterError(this.message);
}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

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