import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/request_entity/verify_reset_code_entity.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/response_entity/verify_reset_response_entity.dart';
import 'package:flower_app/features/auth/forgot_password/domain/repository/verify_reset_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyResetUseCase {
  VerifyResetRepository repo;
  VerifyResetUseCase({required this.repo});
  Future<ApiResult<ResetCodeResponseEntity>> call(
    ResetCodeRequestEntity request,
  ) async {
    return await repo.verifyReset(request);
  }
}
