import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/request_entity/verify_reset_code_entity.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/response_entity/verify_reset_response_entity.dart';

abstract class VerifyResetRepository {
  Future<ApiResult<ResetCodeResponseEntity>> verifyReset(ResetCodeRequestEntity request);
}