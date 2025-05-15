import 'package:flower_app/features/auth/change_password/domain/entity/response_model_eintity/change_password_response_enitity.dart';

class ChangePasswordResponseDto extends ChangePasswordResponse {
  ChangePasswordResponseDto({
    required String message,
    required String token,
  }) : super(message: message, token: token);

  factory ChangePasswordResponseDto.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponseDto(
      message: json['message'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
    };
  }
}
