import 'package:flower_app/features/auth/forgot_password/domain/entity/response_entity/forgot_password_response_entity.dart';

class ForgotPasswordResponseDto {
  final String message;
  final String info;

  ForgotPasswordResponseDto({
    required this.message,
    required this.info,
  });

  // من JSON إلى Model
  factory ForgotPasswordResponseDto.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponseDto(
      message: json['message'] as String,
      info: json['info'] as String,
    );
  }

  // من Model إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'info': info,
    };
  }

  // من Model إلى Entity
  ForgotPasswordResponseEntity toEntity() {
    return ForgotPasswordResponseEntity(
      message: message,
      info: info,
    );
  }

  // من Entity إلى Model
  factory ForgotPasswordResponseDto.fromEntity(ForgotPasswordResponseEntity entity) {
    return ForgotPasswordResponseDto(
      message: entity.message,
      info: entity.info,
    );
  }
}
