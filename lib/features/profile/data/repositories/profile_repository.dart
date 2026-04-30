import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/errors/exceptions.dart';
import 'package:movies/core/errors/failure.dart';
import 'package:movies/core/models/movie.dart';
import 'package:movies/features/profile/data/data_sources/remote/profile_remote_data_source.dart';

@lazySingleton
class ProfileRepository {
  final ProfileRemoteDataSource _dataSource;

  const ProfileRepository(this._dataSource);

  Future<Either<Failure, List<Movie>>> getMoviesByIds(List<String> ids) async {
    try {
      final responses = await Future.wait(
        ids.map((id) => _dataSource.getMoviesByIds(int.parse(id))),
      );
      final movies = responses.map((e) => e.movie).toList();
      return Right(movies);
    } on RemoteException catch (exception) {
      return Left(Failure(exception.message));
    }
  }
}
