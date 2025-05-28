import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/forgot_password/data/data_source/contract/forgot_password_contract_datasource.dart';
import 'package:flower_app/features/auth/forgot_password/data/dto/request_dto/forgot_password_request_dto.dart';
import 'package:flower_app/features/auth/forgot_password/data/dto/response_dto/forgot_password_response_dto.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/request_entity/forgot_password_entity.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/response_entity/forgot_password_response_entity.dart';
import 'package:flower_app/features/auth/forgot_password/domain/repository/forgot_password_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgotPasswordRepository)
class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final ForgotPasswordContractDataSource contractDataSource;

  ForgotPasswordRepositoryImpl({required this.contractDataSource});

  @override
  Future<ApiResult<ForgotPasswordResponseEntity>> sendEmail(
    ForgotPasswordRequestEntity requestEntity,
  ) async {
    final result = await contractDataSource.sendResetPasswordEmail(
      ForgotPasswordRequestDto.fromEntity(requestEntity),
    );
    // Convert ForgotPasswordResponseDto to ForgotPasswordResponseEntity if needed
    if (result is ApiSuccessResult<ForgotPasswordResponseDto>) {
      return ApiSuccessResult(data: result.data.toEntity());
    } else if (result is ApiErrorResult<ForgotPasswordResponseDto>) {
      return ApiErrorResult(failures: result.failures);
    }
    throw Exception('Unknown ApiResult type');
  }
}
