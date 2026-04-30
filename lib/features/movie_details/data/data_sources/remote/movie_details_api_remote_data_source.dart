import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/constants.dart';
import 'package:movies/core/errors/exceptions.dart';
import 'package:movies/features/movie_details/data/data_sources/remote/movie_details_remote_data_source.dart';
import 'package:movies/core/models/movie_details_response.dart';
import 'package:movies/features/movie_details/data/models/movie_suggestions_response.dart';

@LazySingleton(as: MovieDetailsRemoteDataSource)
class MovieDetailsAPIRemoteDataSource implements MovieDetailsRemoteDataSource {
  final Dio _dio;

  const MovieDetailsAPIRemoteDataSource(this._dio);

  @override
  Future<MovieDetailsResponse> getMovieDetails({required int id}) async {
    try {
      final response = await _dio.get(
        APIConstants.movieDetailsEndpoint,
        queryParameters: {
          'movie_id': id,
          'with_cast': true,
          'with_images': true,
        },
      );
      return MovieDetailsResponse.fromJson(response.data);
    } catch (exception) {
      String? message;
      if (exception is DioException) {
        message = exception.response?.data['message'];
      }
      throw RemoteException(message ?? 'Failed to get movies');
    }
  }

  @override
  Future<MovieSuggestionsResponse> getMovieSuggestions({
    required int id,
  }) async {
    try {
      final response = await _dio.get(
        APIConstants.movieSuggestionsEndpoint,
        queryParameters: {'movie_id': id},
      );
      return MovieSuggestionsResponse.fromJson(response.data);
    } catch (exception) {
      String? message;
      if (exception is DioException) {
        message = exception.response?.data['message'];
      }
      throw RemoteException(message ?? 'Failed to get movies');
    }
  }
}
