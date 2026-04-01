import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/constants.dart';
import 'package:movies/core/errors/exceptions.dart';
import 'package:movies/features/home/data/data_sources/remote/movies_remote_data_source.dart';
import 'package:movies/features/home/data/models/movies_response.dart';

@LazySingleton(as: MoviesRemoteDataSource)
class MoviesApiRemoteDataSource implements MoviesRemoteDataSource {
  final Dio _dio;

  const MoviesApiRemoteDataSource(this._dio);

  @override
  Future<MoviesResponse> getMovies({
    String? query,
    String? genres,
    String? sortBy,
    int? minimumRating,
    required int page,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': 20,
      };

      if (query != null) {
        queryParams['query_term'] = query;
      }
      if (genres != null) {
        queryParams['genre'] = genres;
      }

      if (minimumRating != null) {
        queryParams['minimum_rating'] = minimumRating;
      }

      if (sortBy != null) {
        queryParams['sort_by'] = sortBy;
      }

      final response = await _dio.get(
        APIConstants.moviesEndpoint,
        queryParameters: queryParams.isEmpty ? null : queryParams,
      );
      return MoviesResponse.fromJson(response.data);
    } catch (exception) {
      String? message;
      if (exception is DioException) {
        message = exception.response?.data['message'];
      }
      throw RemoteException(message ?? 'Failed to get movies');
    }
  }
}
