import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/request_entity/reset_password_entity.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/response_entity/reset_password_response_entity.dart';
import 'package:flower_app/features/auth/forgot_password/domain/repository/reset_password_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUseCase {
  ResetPasswordRepository repo;
  ResetPasswordUseCase({required this.repo});
  Future<ApiResult<ResetPasswordResponseEntity>> call(
    ResetPasswordRequestEntity request,
  ) async {
    return await repo.resetPassword(request);
  }
}
