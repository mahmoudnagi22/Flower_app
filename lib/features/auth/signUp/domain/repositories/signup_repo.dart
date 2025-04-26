import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/signUp/domain/entities/signup_request_entity.dart';
import 'package:flower_app/features/auth/signUp/domain/entities/signup_response_entity.dart';

abstract class SignupRepo {
  Future<ApiResult<SignupResponseEntity>> signup(SignupRequestEntity signup);
}
