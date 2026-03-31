import 'package:movies/core/models/movie.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class GetMovieDetailsLoading extends MovieDetailsState {}

class GetMovieDetailsSuccess extends MovieDetailsState {
  Movie movie;

  GetMovieDetailsSuccess(this.movie);
}

class GetMovieDetailsError extends MovieDetailsState {
  String errorMessage;

  GetMovieDetailsError(this.errorMessage);
}

class GetMovieSuggestionsLoading extends MovieDetailsState {}

class GetMovieSuggestionsSuccess extends MovieDetailsState {
  List<Movie> movies;

  GetMovieSuggestionsSuccess(this.movies);
}

class GetMovieSuggestionsError extends MovieDetailsState {
  String errorMessage;

  GetMovieSuggestionsError(this.errorMessage);
}
