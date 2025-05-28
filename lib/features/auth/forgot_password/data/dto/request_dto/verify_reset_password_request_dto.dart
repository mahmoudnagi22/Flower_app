import 'package:flower_app/features/auth/forgot_password/domain/entity/request_entity/verify_reset_code_entity.dart';

class ResetCodeRequestDto {
  final String resetCode;

  ResetCodeRequestDto({
    required this.resetCode,
  });

  // من JSON إلى Model
  factory ResetCodeRequestDto.fromJson(Map<String, dynamic> json) {
    return ResetCodeRequestDto(
      resetCode: json['resetCode'] as String,
    );
  }

  // من Model إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'resetCode': resetCode,
    };
  }

  // من Model إلى Entity
  ResetCodeRequestEntity toEntity() {
    return ResetCodeRequestEntity(
      resetCode: resetCode,
    );
  }

  // من Entity إلى Model (اختياري)
  factory ResetCodeRequestDto.fromEntity(ResetCodeRequestEntity entity) {
    return ResetCodeRequestDto(
      resetCode: entity.resetCode,
    );
  }
}
