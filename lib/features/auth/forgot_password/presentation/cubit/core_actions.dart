import 'package:flower_app/features/auth/forgot_password/domain/entity/request_entity/forgot_password_entity.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/request_entity/reset_password_entity.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/request_entity/verify_reset_code_entity.dart';

sealed class ForgotPasswordCoreActions {}

class ForgetPasswordAction implements ForgotPasswordCoreActions {
  ForgotPasswordRequestEntity model;
  ForgetPasswordAction(this.model);
}

class ResetPasswordAction implements ForgotPasswordCoreActions {
  ResetPasswordRequestEntity model;
  ResetPasswordAction(this.model);
}

class VerifyResetCodeAction implements ForgotPasswordCoreActions {
  ResetCodeRequestEntity model;
  VerifyResetCodeAction(this.model);
}
