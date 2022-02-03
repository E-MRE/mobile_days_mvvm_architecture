import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile_days_mvvm_architecture/repositories/abstract/anime_repository.dart';
import 'package:mobile_days_mvvm_architecture/repositories/concrete/remote_anime_repository.dart';

import 'anime_search_state.dart';

class AnimeSearchCubit extends Cubit<AnimeSearchState> {
  AnimeSearchCubit({AnimeRepository? repository})
      : _repository = repository ?? RemoteAnimeRepository(),
        super(const AnimeSearchInitial());

  final AnimeRepository _repository;

  Future<void> searchAnime(String query) async {
    emit(const AnimeSearchLoading());

    var result = await _repository.searchAnime(query);

    emit(result.success
        ? AnimeSearchSuccess(animeList: result.data)
        : AnimeSearchError(error: result.message));
  }
}
