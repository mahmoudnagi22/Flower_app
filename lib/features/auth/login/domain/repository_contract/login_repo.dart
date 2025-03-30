import 'package:dartz/dartz.dart';

import '../../../../../core/error/failers.dart';
import '../../data/model/User.dart';
import '../../data/model/login_user_response.dart';

abstract class LoginRepository{
  Future<Either<Failure,User>> login(LoginUserResponse parameters);
  Future<String?> getToken();
}