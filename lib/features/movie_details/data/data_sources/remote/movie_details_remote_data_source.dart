import 'package:movies/core/models/movie_details_response.dart';
import 'package:movies/features/movie_details/data/models/movie_suggestions_response.dart';

abstract class MovieDetailsRemoteDataSource {
  Future<MovieDetailsResponse> getMovieDetails({required int id});
  
  Future<MovieSuggestionsResponse> getMovieSuggestions({required int id});
}
