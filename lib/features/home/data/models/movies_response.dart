import 'package:movies/core/models/movie.dart';

class MoviesResponse {
  final String status;
  final String statusMessage;
  final int movieCount;
  final int limit;
  final int pageNumber;
  final List<Movie> movies;

  const MoviesResponse({
    required this.status,
    required this.statusMessage,
    required this.movies,
    required this.movieCount,
    required this.limit,
    required this.pageNumber,
  });

  factory MoviesResponse.fromJson(Map<String, dynamic> json) {
    return MoviesResponse(
      status: json['status'] as String,
      statusMessage: json['status_message'] as String,
      movieCount: json['data']['movie_count'] as int,
      limit: json['data']['limit'] as int,
      pageNumber: json['data']['page_number'] as int,
      movies: (json['data']['movies'] as List)
          .map((e) => Movie.fromJson(e))
          .toList(),  
    );
  }
}
