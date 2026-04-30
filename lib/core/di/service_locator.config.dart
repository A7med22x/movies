// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:movies/core/di/register_module.dart' as _i54;
import 'package:movies/features/auth/data/data_source/auth_data_source.dart'
    as _i29;
import 'package:movies/features/auth/data/data_source/auth_firebase_data_source.dart'
    as _i585;
import 'package:movies/features/auth/data/data_source/auth_shared_pref_local_data_source.dart'
    as _i818;
import 'package:movies/features/auth/data/repository/auth_repository.dart'
    as _i490;
import 'package:movies/features/auth/view_model/auth_view_model.dart' as _i891;
import 'package:movies/features/home/data/data_sources/remote/movies_api_remote_data_source.dart'
    as _i398;
import 'package:movies/features/home/data/data_sources/remote/movies_remote_data_source.dart'
    as _i696;
import 'package:movies/features/home/data/repositories/movies_repository.dart'
    as _i194;
import 'package:movies/features/home/view_model/movies_view_model.dart'
    as _i164;
import 'package:movies/features/movie_details/data/data_sources/remote/movie_details_api_remote_data_source.dart'
    as _i816;
import 'package:movies/features/movie_details/data/data_sources/remote/movie_details_remote_data_source.dart'
    as _i149;
import 'package:movies/features/movie_details/data/repositories/movie_details_repository.dart'
    as _i129;
import 'package:movies/features/movie_details/view_model/movie_details_view_model.dart'
    as _i92;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.sharedPref,
      preResolve: true,
    );
    gh.singleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i696.MoviesRemoteDataSource>(
      () => _i398.MoviesApiRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i149.MovieDetailsRemoteDataSource>(
      () => _i816.MovieDetailsAPIRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.singleton<_i29.AuthDataSource>(() => _i585.AuthFirebaseDataSource());
    gh.lazySingleton<_i129.MovieDetailsRepository>(
      () => _i129.MovieDetailsRepository(
        gh<_i149.MovieDetailsRemoteDataSource>(),
      ),
    );
    gh.singleton<_i818.AuthSharedPrefLocalDataSource>(
      () => _i818.AuthSharedPrefLocalDataSource(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i194.MoviesRepository>(
      () => _i194.MoviesRepository(gh<_i696.MoviesRemoteDataSource>()),
    );
    gh.factory<_i164.MoviesViewModel>(
      () => _i164.MoviesViewModel(gh<_i194.MoviesRepository>()),
    );
    gh.singleton<_i490.AuthRepository>(
      () => _i490.AuthRepository(
        gh<_i29.AuthDataSource>(),
        gh<_i818.AuthSharedPrefLocalDataSource>(),
      ),
    );
    gh.factory<_i92.MovieDetailsViewModel>(
      () => _i92.MovieDetailsViewModel(gh<_i129.MovieDetailsRepository>()),
    );
    gh.singleton<_i891.AuthViewModel>(
      () => _i891.AuthViewModel(gh<_i490.AuthRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i54.RegisterModule {}
