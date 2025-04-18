

import 'package:flower_app/core/models/api_result.dart';

import '../model/login_user_response.dart';

abstract class LoginDataSource{
  Future<ApiResult> login(LoginUserResponse parameters);

}