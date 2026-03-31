import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/errors/exceptions.dart';
import 'package:movies/core/errors/failure.dart';
import 'package:movies/core/models/movie.dart';
import 'package:movies/features/movie_details/data/data_sources/remote/movie_details_remote_data_source.dart';

@lazySingleton
class MovieDetailsRepository {
  final MovieDetailsRemoteDataSource _dataSource;

  const MovieDetailsRepository(this._dataSource);

  Future<Either<Failure, Movie>> getMovieDetails({required int id}) async {
    try {
      final response = await _dataSource.getMovieDetails(id: id);
      return Right(response.movie);
    } on RemoteException catch (exception) {
      return Left(Failure(exception.message));
    }
  }

  Future<Either<Failure, List<Movie>>> getMovieSuggestions({
    required int id,
  }) async {
    try {
      final response = await _dataSource.getMovieSuggestions(id: id);
      return Right(response.movies);
    } on RemoteException catch (exception) {
      return Left(Failure(exception.message));
    }
  }
}
