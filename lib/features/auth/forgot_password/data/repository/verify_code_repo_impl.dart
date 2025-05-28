import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/forgot_password/data/data_source/contract/verify_code_contract_datasource.dart';
import 'package:flower_app/features/auth/forgot_password/data/dto/request_dto/verify_reset_password_request_dto.dart';
import 'package:flower_app/features/auth/forgot_password/data/dto/response_dto/verify_reset_password_response_dto.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/request_entity/verify_reset_code_entity.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/response_entity/verify_reset_response_entity.dart';
import 'package:flower_app/features/auth/forgot_password/domain/repository/verify_reset_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: VerifyResetRepository)
class VerifyCodeRepositoryImpl implements VerifyResetRepository {
  final VerifyCodeContractDataSource contractDataSource;

  VerifyCodeRepositoryImpl({required this.contractDataSource});

  @override
  Future<ApiResult<ResetCodeResponseEntity>> verifyReset(
    ResetCodeRequestEntity requestEntity,
  ) async {
    final result = await contractDataSource.verifyCode(
      ResetCodeRequestDto.fromEntity(requestEntity),
    );
    // Convert ForgotPasswordResponseDto to ForgotPasswordResponseEntity if needed
    if (result is ApiSuccessResult<ResetCodeResponseDto>) {
      return ApiSuccessResult(data: result.data.toEntity());
    } else if (result is ApiErrorResult<ResetCodeResponseDto>) {
      return ApiErrorResult(failures: result.failures);
    }
    throw Exception('Unknown ApiResult type');
  }
}
