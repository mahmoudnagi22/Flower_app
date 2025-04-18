
import '../../../../../core/models/api_result.dart';
import '../../data/model/login_user_response.dart';

abstract class LoginRepository{
  Future<ApiResult> login(LoginUserResponse parameters);

}