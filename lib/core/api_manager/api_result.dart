import '../utils/failures.dart';

sealed class ApiResult<T> {}

class ApiSuccessResult<T> extends ApiResult<T> {
  T data;

  ApiSuccessResult({required this.data});
}

class ApiErrorResult<T> extends ApiResult<T> {
  Failures failures;

  ApiErrorResult({required this.failures});
}
