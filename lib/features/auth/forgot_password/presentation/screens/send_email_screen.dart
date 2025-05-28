import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/l10n/app_localizations.dart';
import 'package:flower_app/features/auth/forgot_password/presentation/cubit/core_actions.dart';
import 'package:flower_app/features/auth/forgot_password/presentation/cubit/forgot_password_cubit.dart';
import 'package:flower_app/features/auth/forgot_password/presentation/cubit/forgot_password_state.dart';
import 'package:flower_app/features/auth/forgot_password/domain/entity/request_entity/forgot_password_entity.dart';
import 'package:flower_app/features/auth/signUp/presentation/widgets/custom_button.dart';
import 'package:flower_app/features/auth/signUp/presentation/widgets/custom_form_field.dart';
import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendEmailScreen extends StatelessWidget {
  const SendEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => getIt<ForgotPasswordCubit>(),
      child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            Navigator.pushNamed(context, "/verifyCodeScreen");
          } else if (state.status == Status.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? "An error occurred.")),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(lang.forgetPassword),
            backgroundColor: Colors.white,
          ),
          body: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
            builder: (context, state) {
              final cubit = context.read<ForgotPasswordCubit>();
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        lang.forgetPassword,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Please enter your email associated to\n your account',
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
                            return "Email is required";
                          } else if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                        key: const ValueKey("email_field"),
                        autoFocus: false,
                        isObscure: false,
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
                                final email = cubit.emailController.text.trim();
                                cubit.doIntent(
                                  ForgetPasswordAction(
                                    ForgotPasswordRequestEntity(email: email),
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
