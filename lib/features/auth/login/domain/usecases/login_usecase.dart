import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/login/data/model/login_user_response.dart';
import 'package:flower_app/features/auth/login/domain/repository_contract/login_repo.dart';

class LoginUseCase {
  LoginRepository loginRepository;
  LoginUseCase({required this.loginRepository});

  Future<ApiResult> call(LoginUserResponse parameters) =>
      loginRepository.login(parameters);
}
