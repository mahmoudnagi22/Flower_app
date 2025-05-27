import 'package:flower_app/features/auth/forgot_password/domain/entity/request_entity/forgot_password_entity.dart';

class ForgotPasswordRequestDto {
  final String email;

  ForgotPasswordRequestDto({required this.email});

  // من JSON إلى Model
  factory ForgotPasswordRequestDto.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordRequestDto(
      email: json['email'] as String,
    );
  }

  // من Model إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }

  // من Model إلى Entity
  ForgotPasswordRequestEntity toEntity() {
    return ForgotPasswordRequestEntity(email: email);
  }

  // من Entity إلى Model
  factory ForgotPasswordRequestDto.fromEntity(ForgotPasswordRequestEntity entity) {
    return ForgotPasswordRequestDto(email: entity.email);
  }
}
