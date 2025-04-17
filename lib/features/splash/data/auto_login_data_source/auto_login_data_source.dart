import '../../../../core/api_manager/api_result.dart';

abstract class AutoLoginDataSource {
  Future<ApiResult> autoLogin();
}
