import 'dart:async';

import 'package:flower_app/features/forget_password/domain/repositories/forgot_password_repository.dart';
import 'package:flower_app/features/forget_password/presentation/view_model/forgot_password_state.dart';
import 'package:flower_app/features/forget_password/presentation/views/otp_screen.dart';
import 'package:flower_app/features/forget_password/presentation/views/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository repository;
  ForgotPasswordCubit(this.repository) : super(ForgotPasswordInitial());
  bool canResend = true;
  int countdown = 30;
  void sendResetEmail(String email, BuildContext context) async {
    emit(ForgotPasswordLoading());
    try {
      await repository.sendResetEmail(email);
      emit(ForgotPasswordEmailSent());
      canResend = false;
      countdown = 30;
      startResendTimer();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OtpScreen(email: email)),
      );
    } catch (e) {
      emit(ForgotPasswordError(e.toString().replaceAll("Exception:", "")));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceAll("Exception:", ""))),
      );
    }
  }

  void verifyCode(String code, BuildContext context) async {
    emit(ForgotPasswordLoading());
    try {
      await repository.verifyResetCode(code);
      emit(ForgotPasswordCodeVerified());
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
      );
    } catch (e) {
      emit(ForgotPasswordError(e.toString().replaceAll("Exception:", "")));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceAll("Exception:", ""))),
      );
    }
  }
  void startResendTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        countdown--;
      } else {
        canResend = true;
        timer.cancel();
      }
      emit(ForgotPasswordInitial());
    });
  }

  void resetPassword(String email, String newPassword, BuildContext context) async {
    emit(ForgotPasswordLoading());
    try {
      await repository.resetPassword(email, newPassword);
      emit(ForgotPasswordResetSuccess());
    } catch (e) {
      emit(ForgotPasswordError(e.toString().replaceAll("Exception:", "")));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceAll("Exception:", ""))),
      );
    }
  }
}