import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/features/auth/data/models/user_model.dart';
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

  UserModel? currentUser;

  void updateCurrentUser(UserModel? user) {
    currentUser = user;
    if (user != null) {
      emit(UserUpdated(user));
    }
  }

  bool checkMovieIsFavorite(String movieId) {
    return currentUser!.favoriteMoviesIds!.contains(movieId);
  }

  Future<void> addMovieToFavorites(String movieId) async {
    if (currentUser == null) return;

    currentUser!.favoriteMoviesIds ??= [];
    if (!currentUser!.favoriteMoviesIds!.contains(movieId)) {
      currentUser!.favoriteMoviesIds!.add(movieId);
    }

    emit(UserUpdated(currentUser!));

    final result = await repository.addMovieToFavorites(movieId);

    result.fold((failure) {
      currentUser!.favoriteMoviesIds!.remove(movieId);
      emit(UserUpdated(currentUser!));
    }, (_) {});
  }

  Future<void> removeMovieFromFavorites(String movieId) async {
    if (currentUser == null) return;
    if (currentUser!.favoriteMoviesIds!.contains(movieId)) {
      currentUser!.favoriteMoviesIds?.remove(movieId);
    }

    emit(UserUpdated(currentUser!));

    final result = await repository.removeMovieFromFavorites(movieId);

    result.fold((failure) {
      currentUser!.favoriteMoviesIds?.add(movieId);
      emit(UserUpdated(currentUser!));
    }, (_) {});
  }

  Future<void> addMovieToMoviesWatchedHistory(String movieId) async {
    if (currentUser == null) return;

    currentUser!.moviesWatchedHistoryIds!.remove(movieId);
    currentUser!.moviesWatchedHistoryIds!.insert(0, movieId);

    emit(UserUpdated(currentUser!));

    final result = await repository.addMovieToMoviesWatchedHistory(movieId);

    result.fold((failure) {
      currentUser!.moviesWatchedHistoryIds!.remove(movieId);
      emit(UserUpdated(currentUser!));
    }, (_) {});
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    final result = await repository.logout();
    result.fold(
      (failure) => emit(LogoutError(failure.message)),
      (_) => emit(LogoutSuccess()),
    );
  }

  Future<void> deleteUser(String password) async {
    emit(DeleteUserLoading());
    final result = await repository.deleteUser(password);
    result.fold(
      (failure) => emit(DeleteUserError(failure.message)),
      (_) => emit(DeleteUserSuccess()),
    );
  }
}
