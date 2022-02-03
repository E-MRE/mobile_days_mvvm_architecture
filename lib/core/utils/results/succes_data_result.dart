import 'data_result.dart';

class SuccessDataResult<T> extends DataResult<T> {
  SuccessDataResult({required T data, String message = '', int? statusCode})
      : super(
          data: data,
          message: message,
          statusCode: statusCode,
          success: true,
        );
}
