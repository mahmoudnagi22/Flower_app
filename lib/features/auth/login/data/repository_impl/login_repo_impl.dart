import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/core/error/app_exceptions.dart';
import 'package:flower_app/core/error/failers.dart';
import 'package:flower_app/features/auth/login/data/datasource_contract/login_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:flower_app/features/auth/login/domain/entities/user_entities.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/models/user_model.dart';
import '../../domain/repository_contract/login_repo.dart';
import '../model/login_user_response.dart';

@singleton
class LoginRepositoryImpl implements LoginRepository {
  LoginDataSource loginDataSource;

  LoginRepositoryImpl({required this.loginDataSource});

  @override
  Future<ApiResult> login(LoginUserResponse parameters) =>
      loginDataSource.login(parameters);
}
