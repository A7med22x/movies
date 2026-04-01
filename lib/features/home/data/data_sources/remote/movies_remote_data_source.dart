import 'package:movies/features/home/data/models/movies_response.dart';

abstract class MoviesRemoteDataSource {
  Future<MoviesResponse> getCarouselMovies({
    required String sortBy,
    required int minimumRating,
    required int page 
  });

  Future<MoviesResponse> getGenersMovies({
    required String genres,
    String? sortBy,
    required int page 
  });

  Future<MoviesResponse> getSearchMovies({
    required String query,
    required int page 
  });
}
