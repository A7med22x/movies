import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/features/home/data/repositories/movies_repository.dart';
import 'package:movies/features/home/view_model/movies_states.dart';

@injectable
class MoviesViewModel extends Cubit<MoviesState> {
  final MoviesRepository _repository;

  MoviesViewModel(this._repository) : super(MoviesInitial());
  int currentIndex = 0;

  Future<void> getMovies({
    String? genres,
    String? sortBy,
    int? minimumRating,
  }) async {
    emit(GetMoviesLoading());
    final result = await _repository.getMovies(
      genres: genres,
      sortBy: sortBy,
      minimumRating: minimumRating,
    );
    result.fold(
      (failure) => emit(GetMoviesError(failure.message)),
      (movies) => emit(GetMoviesSuccess(movies)),
    );
  }
}
