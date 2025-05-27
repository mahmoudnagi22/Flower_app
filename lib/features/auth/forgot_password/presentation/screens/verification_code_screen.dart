import 'dart:async';
import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/l10n/app_localizations.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/request_entity/verify_reset_code_entity.dart';
import 'package:flower_app/features/auth/forgot_password/presentation/cubit/core_actions.dart';
import 'package:flower_app/features/auth/signUp/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/features/auth/forgot_password/presentation/cubit/forgot_password_cubit.dart';
import 'package:flower_app/features/auth/forgot_password/presentation/cubit/forgot_password_state.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  late ForgotPasswordCubit cubit;
  int _secondsRemaining = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    cubit = getIt<ForgotPasswordCubit>();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
        setState(() {});
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    cubit.codeController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return BlocProvider.value(
      value: cubit,
      child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            if (state.successType == ForgotPasswordSuccessType.verifyCode) {
              Navigator.pushNamed(context, "/resetPasswordScreen");
            } else if (state.successType ==
                ForgotPasswordSuccessType.resendCode) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message ?? "The code has been resent successfully.",
                  ),
                ),
              );
            }
          } else if (state.status == Status.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message ?? "An error occurred during verification.",
                ),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(lang.forgetPassword),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          body: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Email Verification',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Please enter the code sent to your email address',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF535353),
                        ),
                      ),
                      const SizedBox(height: 20),
                      PinCodeTextField(
                        appContext: context,
                        length: 6,
                        controller: cubit.codeController,
                        keyboardType: TextInputType.number,
                        autoFocus: true,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: 60,
                          fieldWidth: 50,
                          activeFillColor: Colors.grey.shade300,
                          selectedFillColor: Colors.grey.shade200,
                          inactiveFillColor: Colors.grey.shade300,
                          inactiveColor: Colors.grey,
                          selectedColor: ColorManager.bank,
                          activeColor: ColorManager.bank,
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Code is required";
                          } else if (value.length < 6) {
                            return "Enter complete code";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _secondsRemaining > 0
                            ? "Resend code in $_secondsRemaining seconds"
                            : lang.didntreceivecode,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      if (_secondsRemaining == 0)
                        TextButton(
                          onPressed: () {
                            cubit.resendCode();
                            _startTimer();
                          },
                          child: Text(
                            lang.resend,
                            style: TextStyle(
                              color: ColorManager.bank,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                      state.status == Status.loading
                          ? const CircularProgressIndicator()
                          : CustomButton(
                            onPressed: () {
                              if (cubit.formKey.currentState!.validate()) {
                                final code = cubit.codeController.text.trim();
                                cubit.doIntent(
                                  VerifyResetCodeAction(
                                    ResetCodeRequestEntity(resetCode: code),
                                  ),
                                );
                              }
                            },
                            text: lang.confirm,
                            backgroundColor: ColorManager.bank,
                          ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
