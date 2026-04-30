import 'package:movies/core/models/movie.dart';

class MovieDetailsResponse {
  final String? status;
  final String? statusMessage;
  final Movie movie;

  const MovieDetailsResponse({
    this.status,
    this.statusMessage,
    required this.movie,
  });

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) {
    return MovieDetailsResponse(
      status: json['status'] as String?,
      statusMessage: json['status_message'] as String?,
      movie: Movie.fromJson((json['data']?['movie'] ?? {}) as Map<String, dynamic>),
    );
  }
}
