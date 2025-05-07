import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/login/data/model/login_user_response.dart';

abstract class LoginRepository{
  Future<ApiResult> login(LoginUserResponse parameters);

}