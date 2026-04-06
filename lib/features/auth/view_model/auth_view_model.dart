import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/features/auth/data/repository/auth_repository.dart';
import 'package:movies/features/auth/view_model/auth_states.dart';

@singleton
class AuthViewModel extends Cubit<AuthState> {
  final AuthRepository repository;

  AuthViewModel(this.repository) : super(AuthInitial());
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
  }) async {
    emit(RegisterLoading());
    final result = await repository.register(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phoneNumber: phoneNumber,
    );
    if (isClosed) return;
    result.fold(
      (failure) => emit(RegisterError(failure.message)),
      (result) => emit(RegisterSuccess(result)),
    );
  }

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    final result = await repository.login(email: email, password: password);
    if (isClosed) return;
    result.fold(
      (failure) => emit(LoginError(failure.message)),
      (result) => emit(LoginSuccess(result)),
    );
  }

  Future<void> loginWithGoogle() async {
    emit(GoogleLoginLoading());
    final result = await repository.signInWithGoogle();
    if (isClosed) return;
    result.fold(
      (failure) => emit(GoogleLoginError(failure.message)),
      (_) => emit(GoogleLoginSuccess()),
    );
  }
}
