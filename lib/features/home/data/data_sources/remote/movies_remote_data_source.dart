import 'package:movies/features/home/data/models/movies_response.dart';

abstract class MoviesRemoteDataSource {
  Future<MoviesResponse> getMovies({
    String? genres,
    String? sortBy,
    int? minimumRating,
  });
}
