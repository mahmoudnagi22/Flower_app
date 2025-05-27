import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/forgot_password/data/api_call/forgot_password_api_call.dart';
import 'package:flower_app/features/auth/forgot_password/data/data_source/contract/forgot_password_contract_datasource.dart';
import 'package:flower_app/features/auth/forgot_password/data/dto/request_dto/forgot_password_request_dto.dart';
import 'package:flower_app/features/auth/forgot_password/data/dto/response_dto/forgot_password_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgotPasswordContractDataSource)
class ForgotPasswordRemoteDataSource
    implements ForgotPasswordContractDataSource {
  ForgotPasswordService forgotPasswordService;
  ForgotPasswordRemoteDataSource({required this.forgotPasswordService});
  @override
  Future<ApiResult<ForgotPasswordResponseDto>> sendResetPasswordEmail(
    ForgotPasswordRequestDto request,
  ) async {
    return await forgotPasswordService.forgotPassword(request);
  }
}
