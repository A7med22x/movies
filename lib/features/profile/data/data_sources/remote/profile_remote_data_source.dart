import 'package:movies/core/models/movie_details_response.dart';

abstract class ProfileRemoteDataSource {
  Future<MovieDetailsResponse> getMoviesByIds(int id);
}
