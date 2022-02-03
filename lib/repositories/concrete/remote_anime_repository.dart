import 'dart:convert';

import '../../core/constants/api_constants.dart';
import '../../core/data/abstract/remote_data_service.dart';
import '../../core/data/concrete/http_remote_data_manager.dart';
import '../../core/utils/results/data_result.dart';
import '../../core/utils/results/error_data_result.dart';
import '../../core/utils/results/succes_data_result.dart';
import '../../models/anime_search_model.dart';
import '../abstract/anime_repository.dart';

class RemoteAnimeRepository implements AnimeRepository {
  final RemoteDataService _dataService;

  RemoteAnimeRepository({RemoteDataService? dataService})
      : _dataService = dataService ?? HttpRemoteDataManager();

  @override
  Future<DataResult<List<AnimeSearchModel>>> searchAnime(String query) async {
    var result = await _dataService.get(
      endpoint: Endpoints.searchAnime,
      query: query,
    );

    if (!result.success) {
      return ErrorDataResult(message: result.message);
    }

    var json = jsonDecode(result.data);

    if (json['results'] == null || json['results'] is! List) {
      return ErrorDataResult(message: 'Hatalı veri!');
    }

    var list = (json['results'] as List)
        .map((item) => AnimeSearchModel.fromJson(item))
        .toList();

    return SuccessDataResult(data: list);
  }
}
