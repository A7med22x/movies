import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/constants.dart';
import 'package:movies/core/errors/exceptions.dart';
import 'package:movies/core/models/movie_details_response.dart';
import 'package:movies/features/profile/data/data_sources/remote/profile_remote_data_source.dart';

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileApiRemoteDataSource implements ProfileRemoteDataSource {
  final Dio _dio;

  const ProfileApiRemoteDataSource(this._dio);

  @override
  Future<MovieDetailsResponse> getMoviesByIds(int id) async {
    try {
      final response = await _dio.get(
        APIConstants.movieDetailsEndpoint,
        queryParameters: {
          'movie_id': id,
          'with_cast': false,
          'with_images': false,
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
}
