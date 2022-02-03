import 'data_result.dart';

class ErrorDataResult<T> extends DataResult<T> {
  ErrorDataResult({T? data, required String message, int? statusCode})
      : super(
          data: data,
          message: message,
          statusCode: statusCode,
          success: false,
        );
}
