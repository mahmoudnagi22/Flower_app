import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/request_entity/forgot_password_entity.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/response_entity/forgot_password_response_entity.dart';
import 'package:flower_app/features/auth/forgot_password/domain/repository/forgot_password_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgotPasswordUseCase {
  ForgotPasswordRepository repo;
  ForgotPasswordUseCase({required this.repo});
  Future<ApiResult<ForgotPasswordResponseEntity>> call(
    ForgotPasswordRequestEntity request,
  ) async {
    return await repo.sendEmail(request);
  }
}
