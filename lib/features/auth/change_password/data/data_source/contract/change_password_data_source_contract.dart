import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/change_password/data/dto/requests/change_password_request_dto.dart';
import 'package:flower_app/features/auth/change_password/data/dto/responses/change_password_response_dto.dart';

abstract class ChangePasswordContract {
  Future<ApiResult<ChangePasswordResponseDto>> changePassword(ChangePasswordRequestDto request);
}
