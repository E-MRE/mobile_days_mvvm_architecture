import 'package:mobile_days_mvvm_architecture/core/utils/results/data_result.dart';
import 'package:mobile_days_mvvm_architecture/models/anime_search_model.dart';

abstract class AnimeRepository {
  Future<DataResult<List<AnimeSearchModel>>> searchAnime(String query);
}
