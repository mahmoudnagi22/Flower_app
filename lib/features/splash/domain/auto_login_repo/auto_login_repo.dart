
import '../../../../core/api_manager/api_result.dart';

abstract class AutoLoginRepo {
  Future<ApiResult> autoLogin();
}