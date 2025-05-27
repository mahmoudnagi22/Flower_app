import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/core/utils/shared_prefs_helper.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/request_entity/forgot_password_entity.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/response_entity/forgot_password_response_entity.dart';
import 'package:flower_app/features/auth/forgot_password/domain/use_case/forgot_password_usecase.dart';
import 'package:flower_app/features/auth/forgot_password/domain/use_case/reset_password_usecase.dart';
import 'package:flower_app/features/auth/forgot_password/domain/use_case/verify_reset_usecase.dart';
import 'package:flower_app/features/auth/forgot_password/presentation/cubit/core_actions.dart';
import 'package:flower_app/features/auth/forgot_password/presentation/cubit/forgot_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final VerifyResetUseCase verifyResetUseCase;

  ForgotPasswordCubit({
    required this.forgotPasswordUseCase,
    required this.resetPasswordUseCase,
    required this.verifyResetUseCase,
  }) : super(const ForgotPasswordState(status: Status.initial));

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void doIntent(ForgotPasswordCoreActions action) {
    if (action is ForgetPasswordAction) {
      _sendEmail(action);
    } else if (action is VerifyResetCodeAction) {
      _verifyResetCode(action);
    } else if (action is ResetPasswordAction) {
      _resetPassword(action);
    }
  }

  //! Send Reset Code
  Future<void> _sendEmail(ForgetPasswordAction obj) async {
    emit(
      state.copyWith(
        status: Status.loading,
        message: null,
        successType: ForgotPasswordSuccessType.none,
      ),
    );
    final result = await forgotPasswordUseCase.call(obj.model);
    switch (result) {
      case ApiSuccessResult<ForgotPasswordResponseEntity> success:
        SharedPrefsHelper.saveEmail(obj.model.email);
        emit(
          state.copyWith(
            status: Status.success,
            message: success.data.message,
            successType: ForgotPasswordSuccessType.none,
          ),
        );
        break;
      case ApiErrorResult<ForgotPasswordResponseEntity> error:
        emit(
          state.copyWith(
            status: Status.error,
            message: error.failures.errorMessage,
            successType: ForgotPasswordSuccessType.none,
          ),
        );
        break;
    }
  }

  //! Verify Reset Code
  Future<void> _verifyResetCode(VerifyResetCodeAction obj) async {
    emit(
      state.copyWith(
        status: Status.loading,
        message: null,
        successType: ForgotPasswordSuccessType.none,
      ),
    );
    final result = await verifyResetUseCase.call(obj.model);
    switch (result) {
      case ApiSuccessResult success:
        emit(
          state.copyWith(
            status: Status.success,
            message: success.data.message,
            successType: ForgotPasswordSuccessType.verifyCode,
          ),
        );
        break;
      case ApiErrorResult error:
        emit(
          state.copyWith(
            status: Status.error,
            message: error.failures.errorMessage,
            successType: ForgotPasswordSuccessType.none,
          ),
        );
        break;
    }
  }

  //! Reset Password
  Future<void> _resetPassword(ResetPasswordAction obj) async {
    emit(
      state.copyWith(
        status: Status.loading,
        message: null,
        successType: ForgotPasswordSuccessType.none,
      ),
    );
    final result = await resetPasswordUseCase.call(obj.model);
    switch (result) {
      case ApiSuccessResult success:
        emit(
          state.copyWith(
            status: Status.success,
            message: success.data.message,
            successType: ForgotPasswordSuccessType.resetPassword,
          ),
        );
        break;
      case ApiErrorResult error:
        emit(
          state.copyWith(
            status: Status.error,
            message: error.failures.errorMessage,
            successType: ForgotPasswordSuccessType.none,
          ),
        );
        break;
    }
  }

  //! Resend Code
  Future<void> resendCode() async {
    final email = await SharedPrefsHelper.getEmail();

    if (email == null || email.isEmpty) {
      emit(
        state.copyWith(
          status: Status.error,
          message: "Please enter your email first to resend the code.",
          successType: ForgotPasswordSuccessType.none,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: Status.loading,
        message: null,
        successType: ForgotPasswordSuccessType.none,
      ),
    );

    final result = await forgotPasswordUseCase.call(
      ForgotPasswordRequestEntity(email: email),
    );

    switch (result) {
      case ApiSuccessResult<ForgotPasswordResponseEntity> success:
        SharedPrefsHelper.saveEmail(email);
        emit(
          state.copyWith(
            status: Status.success,
            message: "تم إعادة إرسال الكود بنجاح: ${success.data.message}",
            successType: ForgotPasswordSuccessType.resendCode,
          ),
        );
        break;
      case ApiErrorResult<ForgotPasswordResponseEntity> error:
        emit(
          state.copyWith(
            status: Status.error,
            message: error.failures.errorMessage,
            successType: ForgotPasswordSuccessType.none,
          ),
        );
        break;
    }
  }
}
