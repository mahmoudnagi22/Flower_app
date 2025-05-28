import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/forgot_password/data/data_source/contract/reset_password_contract_datasource.dart';
import 'package:flower_app/features/auth/forgot_password/data/dto/request_dto/reset_password_request_dto.dart';
import 'package:flower_app/features/auth/forgot_password/data/dto/response_dto/reset_password_response_dto.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/request_entity/reset_password_entity.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/response_entity/reset_password_response_entity.dart';
import 'package:flower_app/features/auth/forgot_password/domain/repository/reset_password_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ResetPasswordRepository)
class ResetPasswordRepositoryImpl implements ResetPasswordRepository {
  final ResetPasswordContractDataSource contractDataSource;

  ResetPasswordRepositoryImpl({required this.contractDataSource});

  @override
  Future<ApiResult<ResetPasswordResponseEntity>> resetPassword(
    ResetPasswordRequestEntity requestEntity,
  ) async {
    final result = await contractDataSource.resetPassword(
      ResetPasswordRequestDto.fromEntity(requestEntity),
    );
    // Convert ForgotPasswordResponseDto to ForgotPasswordResponseEntity if needed
    if (result is ApiSuccessResult<ResetPasswordResponseDto>) {
      return ApiSuccessResult(data: result.data.toEntity());
    } else if (result is ApiErrorResult<ResetPasswordResponseDto>) {
      return ApiErrorResult(failures: result.failures);
    }
    throw Exception('Unknown ApiResult type');
  }
}
