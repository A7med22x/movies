import 'package:movies/features/home/data/models/movies_response.dart';

abstract class MoviesRemoteDataSource {
  Future<MoviesResponse> getMovies({
    String? query,
    String? genres,
    String? sortBy,
    int? minimumRating,
    required int page 
  });
}
