import 'package:movies/core/models/movie.dart';

abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class GetCarouselLoading extends MoviesState {}

class GetCarouselSuccess extends MoviesState {
  final List<Movie> movies;
  GetCarouselSuccess(this.movies);
}

class GetCarouselError extends MoviesState {
  final String message;
  GetCarouselError(this.message);
}

class GetGenersLoading extends MoviesState {}

class GetGenersSuccess extends MoviesState {
  final List<Movie> movies;
  final int movieCount;
  GetGenersSuccess(this.movies, this.movieCount);
}

class GetGenersError extends MoviesState {
  final String message;
  GetGenersError(this.message);
}

class GetSearchMoviesLoading extends MoviesState {}

class GetSearchMoviesSuccess extends MoviesState {
  final List<Movie> movies;
  final int movieCount;

  GetSearchMoviesSuccess(this.movies, this.movieCount);
}

class GetSearchMoviesError extends MoviesState {
  String errorMessage;

  GetSearchMoviesError(this.errorMessage);
}

class MoviesCleared extends MoviesState {}