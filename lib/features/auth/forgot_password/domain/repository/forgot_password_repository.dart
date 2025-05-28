import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/request_entity/forgot_password_entity.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/response_entity/forgot_password_response_entity.dart';

abstract class ForgotPasswordRepository {
  Future<ApiResult<ForgotPasswordResponseEntity>> sendEmail(ForgotPasswordRequestEntity requestEntity);
}