import 'User.dart';

class LoginResponse {
  LoginResponse({
      required this.message,
      required this.user,
      required this.token,});

  LoginResponse.fromJson(dynamic json) :
    message = json['message'],
    user = User.fromJson(json['user']),
    token = json['token'];

  String message;
  User user;
  String   token;



}