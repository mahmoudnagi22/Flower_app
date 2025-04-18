import 'package:dartz/dartz.dart';
import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/core/error/failers.dart';
import 'package:flower_app/core/models/user_model.dart';

import '../../data/model/login_user_response.dart';
import '../repository_contract/login_repo.dart';

class LoginUseCase{
  LoginRepository loginRepository;
  LoginUseCase({required this.loginRepository});

  Future<ApiResult>  call(LoginUserResponse parameters )=> loginRepository.login(parameters);
}