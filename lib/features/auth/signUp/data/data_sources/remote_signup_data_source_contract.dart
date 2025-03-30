

import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/auth/signUp/data/models/signup_request_dto.dart';
import 'package:flower_app/features/auth/signUp/data/models/signup_response_dto.dart';


abstract class RemoteSignupDataSourceContract {
  Future<ApiResult<SignupResponseDto>> signup(SignupRequestDto signup);
}