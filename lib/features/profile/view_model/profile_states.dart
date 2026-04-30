import 'package:movies/core/models/movie.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class GetMoviesByIdsLoading extends ProfileState {}

class GetMoviesByIdsSuccess extends ProfileState {
  List<Movie> movies;

  GetMoviesByIdsSuccess(this.movies);
}

class GetMoviesByIdsError extends ProfileState {
  String errorMessage;

  GetMoviesByIdsError(this.errorMessage);
}