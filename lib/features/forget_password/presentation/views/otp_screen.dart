import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/features/forget_password/presentation/view_model/forgot_password_cubit.dart';
import 'package:flower_app/features/forget_password/presentation/view_model/forgot_password_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  final String email;
  OtpScreen({super.key, required this.email});

  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password'),
        leading: const Icon(CupertinoIcons.back),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "Email Verification",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                SizedBox(height: 15.h),
                const Text(
                  "Please enter your code that was sent to\n your email address ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorManager.grayColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                SizedBox(height: 30.h),
                BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                  listener: (context, state) {
                    if (state is ForgotPasswordResetSuccess) {
                      print("Success");
                    } else if (state is ForgotPasswordError) {
                      _otpController.clear();
                    }
                  },
                  builder: (context, state) {
                    return Pinput(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      length: 4,
                      controller: _otpController,
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length != 4) {
                          return 'Invalid code';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (value.length == 4) {
                          context.read<ForgotPasswordCubit>().verifyCode(value, context);
                        }
                      },
                      defaultPinTheme: PinTheme(
                        height: 68,
                        width: 74,
                        decoration: BoxDecoration(
                          color: ColorManager.lighterGrayColor,
                          border: Border.all(color: ColorManager.lighterGrayColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Didn't receive code?",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: ColorManager.blackBaseColor),
                    ),
                    BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                      builder: (context, state) {
                        final cubit = context.read<ForgotPasswordCubit>();
                        return TextButton(
                          onPressed: cubit.canResend
                              ? () {
                            cubit.sendResetEmail(email,context);
                          }
                              : null,
                          child: Text(
                            cubit.canResend ? "Resend" : "Resend in ${cubit.countdown}s",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: ColorManager.primaryColor,
                                decoration: TextDecoration.underline,
                                decorationColor: ColorManager.primaryColor),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}