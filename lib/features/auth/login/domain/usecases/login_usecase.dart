import 'package:dartz/dartz.dart';
import 'package:flower_app/core/error/failers.dart';

import '../../data/model/User.dart';
import '../../data/model/login_user_response.dart';
import '../repository_contract/login_repo.dart';

class LoginUseCase{
  LoginRepository loginRepository;
  LoginUseCase({required this.loginRepository});

  Future<Either<Failure, User>>  call(LoginUserResponse parameters )=> loginRepository.login(parameters);
}