import '../../../../core/models/api_result.dart';

abstract class AutoLoginDataSource {
  Future<ApiResult> autoLogin();
}
