import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/features/profile/data/repositories/profile_repository.dart';
import 'package:movies/features/profile/view_model/profile_states.dart';

@injectable
class ProfileViewModel extends Cubit<ProfileState> {
  final ProfileRepository _repository;

  ProfileViewModel(this._repository) : super(ProfileInitial());

  Future<void> getMoviesByIds(List<String> ids) async {
    emit(GetMoviesByIdsLoading());
    final result = await _repository.getMoviesByIds(ids);
    result.fold(
      (failure) => emit(GetMoviesByIdsError(failure.message)),
      (movie) => emit(GetMoviesByIdsSuccess(movie)),
    );
  }

  void clearMovies() {
    emit(GetMoviesByIdsLoading());
  }
}
