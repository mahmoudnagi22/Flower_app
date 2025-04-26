import 'package:flower_app/features/auth/change_password/data/dto/requests/change_password_request_dto.dart';
import 'package:flower_app/features/auth/change_password/domain/entity/request_model_entity/change_password_reqest_enitiy.dart';

extension ChangePasswordRequestMapper on ChangePasswordRequest {
  ChangePasswordRequestDto toDto() {
    return ChangePasswordRequestDto(
      password: this.password,
      newPassword: this.newPassword,
    );
  }
}
