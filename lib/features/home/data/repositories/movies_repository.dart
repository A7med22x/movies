import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/errors/exceptions.dart';
import 'package:movies/core/errors/failure.dart';
import 'package:movies/features/home/data/data_sources/remote/movies_remote_data_source.dart';
import 'package:movies/features/home/data/models/movies_response.dart';

@lazySingleton
class MoviesRepository {
  final MoviesRemoteDataSource _dataSource;

  const MoviesRepository(this._dataSource);

  Future<Either<Failure, MoviesResponse>> getMovies({
    String? query,
    String? genres,
    String? sortBy,
    int? minimumRating,
    required int page,
  }) async {
    try {
      final response = await _dataSource.getMovies(
        query: query,
        genres: genres,
        sortBy: sortBy,
        minimumRating: minimumRating,
        page: page,
      );response.movieCount;
      return Right(response);
    } on RemoteException catch (exception) {
      return Left(Failure(exception.message));
    }
  }
}
