import 'result.dart';

class DataResult<T> extends Result {
  final T? data;
  final int? statusCode;

  DataResult(
      {required bool success, this.data, String message = '', this.statusCode})
      : super(success: success, message: message);
}
