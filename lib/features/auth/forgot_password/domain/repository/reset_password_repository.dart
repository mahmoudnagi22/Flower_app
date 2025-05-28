import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/request_entity/reset_password_entity.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/response_entity/reset_password_response_entity.dart';

abstract class ResetPasswordRepository {
  Future<ApiResult<ResetPasswordResponseEntity>> resetPassword(ResetPasswordRequestEntity request);
}