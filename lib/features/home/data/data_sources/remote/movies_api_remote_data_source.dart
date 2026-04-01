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
  Future<MoviesResponse> getCarouselMovies({
    required String sortBy,
    required int minimumRating,
    required int page,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': 20,
        'sort_by': sortBy,
        'minimum_rating': minimumRating,
      };

      final response = await _dio.get(
        APIConstants.moviesEndpoint,
        queryParameters: queryParams,
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

  @override
  Future<MoviesResponse> getGenersMovies({
    required String genres,
    String? sortBy,
    required int page,
  }) async{
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': 20,
        'genre': genres,
      };

      if (sortBy != null) {
        queryParams['sort_by'] = sortBy;
      }

      final response = await _dio.get(
        APIConstants.moviesEndpoint,
        queryParameters: queryParams,
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

  @override
  Future<MoviesResponse> getSearchMovies({
    required String query,
    required int page,
  }) async{
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': 20,
        'query_term': query,
      };

      final response = await _dio.get(
        APIConstants.moviesEndpoint,
        queryParameters: queryParams,
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
