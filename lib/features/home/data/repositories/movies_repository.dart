import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/errors/exceptions.dart';
import 'package:movies/core/errors/failure.dart';
import 'package:movies/core/models/movie.dart';
import 'package:movies/features/home/data/data_sources/remote/movies_remote_data_source.dart';
import 'package:movies/features/home/data/models/movies_response.dart';

@lazySingleton
class MoviesRepository {
  final MoviesRemoteDataSource _dataSource;

  const MoviesRepository(this._dataSource);

  Future<Either<Failure, List<Movie>>> getCarouselMovies({
    required String sortBy,
    required int minimumRating,
    required int page,
  }) async {
    try {
      final response = await _dataSource.getCarouselMovies(
        sortBy: sortBy,
        minimumRating: minimumRating,
        page: page,
      );response.movieCount;
      return Right(response.movies);
    } on RemoteException catch (exception) {
      return Left(Failure(exception.message));
    }
  }
  
  Future<Either<Failure, MoviesResponse>> getGenersMovies({
    String? sortBy,
    required String genres,
    required int page,
  }) async {
    try {
      final response = await _dataSource.getGenersMovies(
        sortBy: sortBy,
        genres: genres,
        page: page,
      );response.movieCount;
      return Right(response);
    } on RemoteException catch (exception) {
      return Left(Failure(exception.message));
    }
  }

  Future<Either<Failure, MoviesResponse>> getSearchMovies({
    required String query,
    required int page,
  }) async {
    try {
      final response = await _dataSource.getSearchMovies(
        query: query,
        page: page,
      );response.movieCount;
      return Right(response);
    } on RemoteException catch (exception) {
      return Left(Failure(exception.message));
    }
  }
}
