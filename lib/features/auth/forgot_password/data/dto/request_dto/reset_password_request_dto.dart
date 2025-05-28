import 'package:flower_app/features/auth/forgot_password/domain/entity/request_entity/reset_password_entity.dart';

class ResetPasswordRequestDto {
  final String email;
  final String newPassword;

  ResetPasswordRequestDto({
    required this.email,
    required this.newPassword,
  });

  // من JSON إلى Model
  factory ResetPasswordRequestDto.fromJson(Map<String, dynamic> json) {
    return ResetPasswordRequestDto(
      email: json['email'] as String,
      newPassword: json['newPassword'] as String,
    );
  }

  // من Model إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'newPassword': newPassword,
    };
  }

  // من Model إلى Entity
  ResetPasswordRequestEntity toEntity() {
    return ResetPasswordRequestEntity(
      email: email,
      newPassword: newPassword,
    );
  }

  // من Entity إلى Model
  factory ResetPasswordRequestDto.fromEntity(ResetPasswordRequestEntity entity) {
    return ResetPasswordRequestDto(
      email: entity.email,
      newPassword: entity.newPassword,
    );
  }
}
