import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/l10n/app_localizations.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/request_entity/reset_password_entity.dart';
import 'package:flower_app/features/auth/forgot_password/presentation/cubit/core_actions.dart';
import 'package:flower_app/features/auth/signUp/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/features/auth/forgot_password/presentation/cubit/forgot_password_cubit.dart';
import 'package:flower_app/features/auth/forgot_password/presentation/cubit/forgot_password_state.dart';
import 'package:flower_app/features/auth/signUp/presentation/widgets/custom_form_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => getIt<ForgotPasswordCubit>(),
      child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            Navigator.pushNamed(context, "/login");
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
            title: Text(lang.resetpassword),
            backgroundColor: Colors.white,
          ),
          body: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
            builder: (context, state) {
              final cubit = context.read<ForgotPasswordCubit>();

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        lang.resetpassword,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Password must not be empty and must contain \n6 characters with upper case letter and one\n number at least  ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF535353),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        labelText: lang.email,
                        hintText: lang.enterEmail,
                        controller: cubit.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Required";
                          }
                          if (!RegExp(
                            r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                          ).hasMatch(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                        autoFocus: true,
                        isObscure: false,
                        onChanged: (value) {},
                        readOnly: false,
                        suffix: null,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        key: const ValueKey("password_field"),
                        labelText: lang.newPassword,
                        hintText: lang.enterPassword,
                        controller: cubit.passwordController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Required";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
                            return "Must contain at least one uppercase letter";
                          }
                          if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
                            return "Must contain at least one number";
                          }
                          return null;
                        },
                        autoFocus: false,
                        isObscure: true,
                        onChanged: (value) {},
                        readOnly: false,
                        suffix: null,
                      ),
                      const SizedBox(height: 40),
                      state.status == Status.loading
                          ? const CircularProgressIndicator()
                          : CustomButton(
                            onPressed: () {
                              if (cubit.formKey.currentState!.validate()) {
                                final newPassword =
                                    cubit.passwordController.text;
                                final email = cubit.emailController.text;

                                cubit.doIntent(
                                  ResetPasswordAction(
                                    ResetPasswordRequestEntity(
                                      email: email,
                                      newPassword: newPassword,
                                    ),
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
