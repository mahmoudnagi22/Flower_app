import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/signUp/data/models/signup_request_dto.dart';
import 'package:flower_app/features/auth/signUp/domain/entities/signup_response_entity.dart';


abstract class RemoteSignupDataSourceContract {
  Future<ApiResult<SignupResponseEntity>> signup(SignupRequestDto signup);
}