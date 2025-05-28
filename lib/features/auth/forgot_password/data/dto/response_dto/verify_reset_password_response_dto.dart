import 'package:flower_app/features/auth/forgot_password/domain/entity/response_entity/verify_reset_response_entity.dart';

class ResetCodeResponseDto {
  final String status;

  ResetCodeResponseDto({required this.status});

  // من JSON إلى Model
  factory ResetCodeResponseDto.fromJson(Map<String, dynamic> json) {
    return ResetCodeResponseDto(status: json['status'] as String);
  }

  // من Model إلى JSON
  Map<String, dynamic> toJson() {
    return {'status': status};
  }

  // من Model إلى Entity
  ResetCodeResponseEntity toEntity() {
    return ResetCodeResponseEntity(message: status);
  }

  // من Entity إلى Model (اختياري)
  factory ResetCodeResponseDto.fromEntity(ResetCodeResponseEntity entity) {
    return ResetCodeResponseDto(status: entity.message);
  }
}
