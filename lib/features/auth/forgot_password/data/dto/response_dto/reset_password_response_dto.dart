import 'package:flower_app/features/auth/forgot_password/domain/entity/response_entity/reset_password_response_entity.dart';

class ResetPasswordResponseDto {
  final String message;
  final String token;

  ResetPasswordResponseDto({
    required this.message,
    required this.token,
  });

  // من JSON إلى Model
  factory ResetPasswordResponseDto.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponseDto(
      message: json['message'] as String,
      token: json['token'] as String,
    );
  }

  // من Model إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
    };
  }

  // تحويل إلى Entity
  ResetPasswordResponseEntity toEntity() {
    return ResetPasswordResponseEntity(
      message: message,
      token: token,
    );
  }

  // من Entity إلى Model (اختياري)
  factory ResetPasswordResponseDto.fromEntity(ResetPasswordResponseEntity entity) {
    return ResetPasswordResponseDto(
      message: entity.message,
      token: entity.token,
    );
  }
}
