
import '../../../../core/models/api_result.dart';

abstract class AutoLoginRepo {
  Future<ApiResult> autoLogin();
}