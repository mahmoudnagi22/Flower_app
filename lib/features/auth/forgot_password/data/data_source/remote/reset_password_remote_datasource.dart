import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/forgot_password/data/api_call/forgot_password_api_call.dart';
import 'package:flower_app/features/auth/forgot_password/data/data_source/contract/reset_password_contract_datasource.dart';
import 'package:flower_app/features/auth/forgot_password/data/dto/request_dto/reset_password_request_dto.dart';
import 'package:flower_app/features/auth/forgot_password/data/dto/response_dto/reset_password_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ResetPasswordContractDataSource)
class ResetPasswordRemoteDataSource implements ResetPasswordContractDataSource {
  ForgotPasswordService resetPasswordService;
  ResetPasswordRemoteDataSource({required this.resetPasswordService});

  @override
  Future<ApiResult<ResetPasswordResponseDto>> resetPassword(
    ResetPasswordRequestDto request,
  ) async {
    return await resetPasswordService.resetPassword(request);
  }
}
