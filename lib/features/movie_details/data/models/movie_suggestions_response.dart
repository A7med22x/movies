import 'package:movies/core/models/movie.dart';

class MovieSuggestionsResponse {
  final String? status;
  final String? statusMessage;
  final int movieCount;
  final List<Movie> movies;

  const MovieSuggestionsResponse({
    this.status,
    this.statusMessage,
    required this.movieCount,
    required this.movies,
  });

  factory MovieSuggestionsResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    final List<Movie> moviesList;

    if (data != null && data['movies'] is List) {
      moviesList = (data['movies'] as List)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      moviesList = [];
    }
    return MovieSuggestionsResponse(
      status: json['status'] as String? ?? '',
      statusMessage: json['status_message'] as String? ?? '',
      movieCount: json['data']?['movie_count'] ?? 0,
      movies: moviesList,
    );
  }
}
