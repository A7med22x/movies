import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/errors/exceptions.dart';
import 'package:movies/core/errors/failure.dart';
import 'package:movies/features/home/data/data_sources/remote/movies_remote_data_source.dart';
import 'package:movies/core/models/movie.dart';

@lazySingleton
class MoviesRepository {
  final MoviesRemoteDataSource _dataSource;

  const MoviesRepository(this._dataSource);

  Future<Either<Failure, List<Movie>>> getMovies({
    String? genres,
    String? sortBy,
    int? minimumRating,
  }) async {
    try {
      final response = await _dataSource.getMovies(
        genres: genres,
        sortBy: sortBy,
        minimumRating: minimumRating,
      );
      return Right(response.movies);
    } on RemoteException catch (exception) {
      return Left(Failure(exception.message));
    }
  }
}
