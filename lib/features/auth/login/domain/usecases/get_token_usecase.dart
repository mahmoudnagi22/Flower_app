import 'package:dartz/dartz.dart';
import 'package:flower_app/core/error/failers.dart';
import '../repository_contract/login_repo.dart';

class GetTokenUseCase{
  LoginRepository loginRepository;
  GetTokenUseCase({required this.loginRepository});

  Future<String?>  call( )=> loginRepository.getToken();
}