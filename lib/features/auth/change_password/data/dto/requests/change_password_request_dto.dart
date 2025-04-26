import 'package:flower_app/features/auth/change_password/domain/entity/request_model_entity/change_password_reqest_enitiy.dart';

class ChangePasswordRequestDto extends ChangePasswordRequest {
  ChangePasswordRequestDto({
    required String password,
    required String newPassword,
  }) : super(
    password: password,
    newPassword: newPassword,
  );

  factory ChangePasswordRequestDto.fromJson(Map<String, dynamic> json) {
    return ChangePasswordRequestDto(
      password: json['password'],
      newPassword: json['newPassword'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'newPassword': newPassword,
    };
  }
}
