import 'package:flower_app/core/error/app_exceptions.dart';
import 'package:flower_app/core/error/failers.dart';
import 'package:flower_app/features/auth/login/data/datasource_contract/login_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:flower_app/features/auth/login/domain/entities/user_entities.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repository_contract/login_repo.dart';
import '../model/User.dart';
import '../model/login_user_response.dart';


@singleton
class LoginRepositoryImpl  implements LoginRepository{
  LoginDataSource loginDataSource;
  LoginRepositoryImpl({required this.loginDataSource});


  @override
  Future<Either<Failure,User>> login(LoginUserResponse parameters)async{
   try {
     var response = await loginDataSource.login(parameters);
     loginDataSource.saveToken(response.token);
     return Right(response.user);
   }on AppException catch(ex){
     Failure failure = Failure(failure: ex.massage);
     return Left(failure);
   }
  }

  @override
  Future<String?> getToken() async{
    var getToken = await loginDataSource.getToken();
    return getToken;
  }
}