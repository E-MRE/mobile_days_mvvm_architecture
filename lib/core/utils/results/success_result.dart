import '/core/utils/results/result.dart';

class SuccessResult extends Result {
  SuccessResult({String message = ''}) : super(success: true, message: '');
}
