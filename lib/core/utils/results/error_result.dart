import '/core/utils/results/result.dart';

class ErrorResult extends Result {
  ErrorResult({String message = ''}) : super(success: false, message: message);
}
