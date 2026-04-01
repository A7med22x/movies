import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/features/home/data/repositories/movies_repository.dart';
import 'package:movies/features/home/view_model/movies_states.dart';

@injectable
class MoviesViewModel extends Cubit<MoviesState> {
  final MoviesRepository _repository;

  MoviesViewModel(this._repository) : super(MoviesInitial());
  int currentIndex = 0;

  Future<void> getCarouselMovies({
    required String sortBy,
    required int minimumRating,
    required int page,
  }) async {
    emit(GetCarouselLoading());
    final result = await _repository.getCarouselMovies(
      sortBy: sortBy,
      minimumRating: minimumRating,
      page: page,
    );
    result.fold(
      (failure) => emit(GetCarouselError(failure.message)),
      (movies) =>
          emit(GetCarouselSuccess(movies)),
    );
  }

  Future<void> getGenersMovies({
    String? sortBy,
    required String genres,
    required int page,
  }) async {
    emit(GetGenersLoading());
    final result = await _repository.getGenersMovies(
      sortBy: sortBy,
      genres: genres,
      page: page,
    );
    result.fold(
      (failure) => emit(GetGenersError(failure.message)),
      (result) =>
          emit(GetGenersSuccess(result.movies, result.movieCount)),
    );
  }

  Future<void> getSearchMovies({
    required String query,
    required int page,
  }) async {
    emit(GetSearchMoviesLoading());
    final result = await _repository.getSearchMovies(
      query: query,
      page: page,
    );
    result.fold(
      (failure) => emit(GetSearchMoviesError(failure.message)),
      (result) =>
          emit(GetSearchMoviesSuccess(result.movies, result.movieCount)),
    );
  }

  void clearMovies() {
    emit(MoviesCleared());
  }
}
