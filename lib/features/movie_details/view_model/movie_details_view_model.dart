import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/features/movie_details/data/repositories/movie_details_repository.dart';
import 'package:movies/features/movie_details/view_model/movie_details_states.dart';

@injectable
class MovieDetailsViewModel extends Cubit<MovieDetailsState> {
  final MovieDetailsRepository _repository;

  MovieDetailsViewModel(this._repository) : super(MovieDetailsInitial());

  Future<void> getMovieDetails({required int id}) async {
    emit(GetMovieDetailsLoading());
    final result = await _repository.getMovieDetails(id: id);
    result.fold(
      (failure) => emit(GetMovieDetailsError(failure.message)),
      (movie) => emit(GetMovieDetailsSuccess(movie)),
    );
  }

  Future<void> getMovieSuggestions({required int id}) async {
    emit(GetMovieSuggestionsLoading());
    final result = await _repository.getMovieSuggestions(id: id);
    result.fold(
      (failure) => emit(GetMovieSuggestionsError(failure.message)),
      (movies) => emit(GetMovieSuggestionsSuccess(movies)),
    );
  }
}
