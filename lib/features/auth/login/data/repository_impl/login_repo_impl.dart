import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/login/data/datasource_contract/login_datasource.dart';
import 'package:flower_app/features/auth/login/data/model/login_user_response.dart';
import 'package:flower_app/features/auth/login/domain/repository_contract/login_repo.dart';
import 'package:injectable/injectable.dart';


@singleton
class LoginRepositoryImpl implements LoginRepository {
  LoginDataSource loginDataSource;

  LoginRepositoryImpl({required this.loginDataSource});

  @override
  Future<ApiResult> login(LoginUserResponse parameters) =>
      loginDataSource.login(parameters);
}
