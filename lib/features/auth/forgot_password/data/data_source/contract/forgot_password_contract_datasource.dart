import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/forgot_password/data/dto/request_dto/forgot_password_request_dto.dart';
import 'package:flower_app/features/auth/forgot_password/data/dto/response_dto/forgot_password_response_dto.dart';

abstract class ForgotPasswordContractDataSource {
  Future<ApiResult<ForgotPasswordResponseDto>> sendResetPasswordEmail(ForgotPasswordRequestDto request);
}