import 'package:movies/core/models/movie.dart';

abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class GetMoviesLoading extends MoviesState {}

class GetMoviesSuccess extends MoviesState {
  final List<Movie> movies;
  final int movieCount;

  GetMoviesSuccess(this.movies, this.movieCount);
}

class GetMoviesError extends MoviesState {
  String errorMessage;

  GetMoviesError(this.errorMessage);
}

class MoviesCleared extends MoviesState {}