import 'package:flower_app/features/auth/signUp/domain/entities/signup_request_entity.dart';

abstract class SignupRepo {
   signup(SignupRequestEntity signup);
}