import 'dart:io';

import 'package:http/http.dart' as http;

import '../../constants/api_constants.dart';
import '../../utils/results/data_result.dart';
import '../../utils/results/error_data_result.dart';
import '../../utils/results/succes_data_result.dart';
import '../abstract/remote_data_service.dart';

class HttpRemoteDataManager implements RemoteDataService {
  @override
  String get baseUrl => ApiConstants.baseUrl;

  HttpRemoteDataManager({http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;
  Map<String, String> get _defaultHeader {
    return {HttpHeaders.contentTypeHeader: 'application/json'};
  }

  @override
  Future<DataResult> get({
    required String endpoint,
    required String query,
    Duration timeout = const Duration(seconds: 10),
    Map<String, String>? header,
  }) async {
    try {
      var uri = Uri.parse(_getUrl(endpoint, query));
      var response = await _client
          .get(uri, headers: header ?? _defaultHeader)
          .timeout(timeout);

      if (response.statusCode != HttpStatus.ok) {
        return ErrorDataResult(
            message: 'Veri alınırken bir hata meydana geldi');
      }

      return SuccessDataResult(data: response.body);
    } catch (error) {
      return ErrorDataResult(message: 'Hata: $error');
    }
  }

  @override
  Future<DataResult> post({
    required String endpoint,
    required Object body,
    Map<String, String>? header,
    Duration timeout = const Duration(seconds: 10),
  }) async {
    try {
      var uri = Uri.parse(_getUrl(endpoint, null));
      var response = await _client
          .post(
            uri,
            headers: header ?? _defaultHeader,
            body: body,
          )
          .timeout(timeout);

      if (response.statusCode != HttpStatus.ok) {
        return ErrorDataResult(
            message: 'Veri alınırken bir hata meydana geldi');
      }

      return SuccessDataResult(data: response.body);
    } catch (error) {
      return ErrorDataResult(message: 'Hata: $error');
    }
  }

  String _getUrl(String endpoint, String? query) {
    return query?.isNotEmpty ?? false
        ? '$baseUrl$endpoint?q=$query'
        : '$baseUrl/$endpoint';
  }
}
