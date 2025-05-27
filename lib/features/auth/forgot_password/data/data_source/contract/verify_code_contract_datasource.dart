import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/forgot_password/data/dto/request_dto/verify_reset_password_request_dto.dart';
import 'package:flower_app/features/auth/forgot_password/data/dto/response_dto/verify_reset_password_response_dto.dart';

abstract class VerifyCodeContractDataSource {
  Future<ApiResult<ResetCodeResponseDto>> verifyCode(ResetCodeRequestDto request);
}