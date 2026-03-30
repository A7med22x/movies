import 'package:movies/features/home/data/models/movie.dart';

class MoviesResponse {
  final String status;
  final String statusMessage;
  final List<Movie> movies;

  const MoviesResponse({
    required this.status,
    required this.statusMessage,
    required this.movies,
  });

  factory MoviesResponse.fromJson(Map<String, dynamic> json) {
    return MoviesResponse(
      status: json['status'] as String,
      statusMessage: json['status_message'] as String,
      movies: (json['data']['movies'] as List)
          .map((e) => Movie.fromJson(e))
          .toList(),
    );
  }
}
