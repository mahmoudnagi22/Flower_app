
import '../model/LoginResponse.dart';
import '../model/login_user_response.dart';

abstract class LoginDataSource{
  Future<LoginResponse> login(LoginUserResponse parameters);
  Future<void> saveToken(String token);
  Future<String?> getToken();
}