import 'package:movies/core/models/movie.dart';

abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class GetMoviesLoading extends MoviesState {}

class GetMoviesSuccess extends MoviesState {
  List<Movie> movies;

  GetMoviesSuccess(this.movies);
}

class GetMoviesError extends MoviesState {
  String errorMessage;

  GetMoviesError(this.errorMessage);
}