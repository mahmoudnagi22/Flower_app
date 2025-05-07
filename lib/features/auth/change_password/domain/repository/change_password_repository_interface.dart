import 'package:flower_app/features/auth/change_password/domain/entity/request_model_entity/change_password_reqest_enitiy.dart';
import 'package:flower_app/features/auth/change_password/domain/entity/response_model_eintity/change_password_response_enitity.dart';
import 'package:flower_app/core/models/api_result.dart';

abstract class ChangePasswordRepository {
  Future<ApiResult<ChangePasswordResponse>> updatePassword(ChangePasswordRequest request);
}
