abstract class AppException implements Exception{
final String massage;
AppException({required this.massage});
}
class LoginException extends AppException{
  LoginException({required super.massage});
}

class AuthException extends AppException{
  AuthException({required super.massage});
}

class TokenException extends AppException{
  TokenException({required super.massage});
}