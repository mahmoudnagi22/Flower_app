import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/change_password/domain/entity/request_model_entity/change_password_reqest_enitiy.dart';
import 'package:flower_app/features/auth/change_password/domain/entity/response_model_eintity/change_password_response_enitity.dart';
import 'package:flower_app/features/auth/change_password/domain/repository/change_password_repository_interface.dart';
import 'package:injectable/injectable.dart';
@injectable
class ChangePasswordUseCase {
  final ChangePasswordRepository repository;

  ChangePasswordUseCase({
    required this.repository,
  });
  Future<ApiResult<ChangePasswordResponse>> call(ChangePasswordRequest request) {
    return repository.updatePassword(request);
  }
}
