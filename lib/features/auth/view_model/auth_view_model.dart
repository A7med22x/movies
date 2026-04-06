import 'package:firebase_auth/firebase_auth.dart';
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
    try {
      await repository.register(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        phoneNumber: phoneNumber,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      emit(RegisterError(e.message ?? 'Registration failed'));
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
     await repository.login(email: email, password: password);
      emit(LoginSuccess());
    }  on FirebaseAuthException catch (e) {
      emit(LoginError(e.message ?? 'Login failed'));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
  Future<void> loginWithGoogle() async {
    emit(GoogleLoginLoading());
    try {
      await repository.signInWithGoogle();
      emit(GoogleLoginSuccess());
    } catch (e) {
      emit(GoogleLoginError(e.toString()));
    }
  }
}
