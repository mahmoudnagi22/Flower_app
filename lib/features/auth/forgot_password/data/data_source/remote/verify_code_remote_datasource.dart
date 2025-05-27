import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/forgot_password/data/api_call/forgot_password_api_call.dart';
import 'package:flower_app/features/auth/forgot_password/data/data_source/contract/verify_code_contract_datasource.dart';
import 'package:flower_app/features/auth/forgot_password/data/dto/request_dto/verify_reset_password_request_dto.dart';
import 'package:flower_app/features/auth/forgot_password/data/dto/response_dto/verify_reset_password_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: VerifyCodeContractDataSource)
class VerifyCodeRemoteDataSource implements VerifyCodeContractDataSource {
  ForgotPasswordService verifyCodeService;
  VerifyCodeRemoteDataSource({required this.verifyCodeService});

  @override
  Future<ApiResult<ResetCodeResponseDto>> verifyCode(
    ResetCodeRequestDto request,
  ) async {
    return await verifyCodeService.verifyCode(request);
  }
}
