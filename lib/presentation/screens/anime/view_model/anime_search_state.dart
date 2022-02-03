import 'package:mobile_days_mvvm_architecture/models/anime_search_model.dart';

abstract class AnimeSearchState {
  const AnimeSearchState();
}

class AnimeSearchInitial implements AnimeSearchState {
  const AnimeSearchInitial();
}

class AnimeSearchLoading implements AnimeSearchState {
  const AnimeSearchLoading();
}

class AnimeSearchSuccess implements AnimeSearchState {
  List<AnimeSearchModel>? animeList;
  AnimeSearchSuccess({this.animeList});
}

class AnimeSearchError implements AnimeSearchState {
  String? error;
  AnimeSearchError({this.error});
}
