import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/l10n/app_localizations.dart';
import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/features/auth/change_password/presentation/cubit/change_password_cubit.dart';
import 'package:flower_app/features/auth/change_password/presentation/cubit/change_password_state.dart';
import 'package:flower_app/features/auth/signUp/presentation/widgets/custom_button.dart';
import 'package:flower_app/features/auth/signUp/presentation/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => getIt<ChangePasswordCubit>(),
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            final storage = FlutterSecureStorage();
            storage.delete(key: 'user_token').then((_) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Center(child: const Text("Successfully completed")),
                  content: const Text("Your password has been changed successfully, you will be logged out."),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login',
                              (route) => false,
                        );
                      },
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            });
          } else if (state.status == Status.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("${state.message}")),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<ChangePasswordCubit>();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: ColorManager.white,
              title: Text(lang.changePassword),
            ),
            body: Form(
              key: cubit.formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                      labelText: lang.changePassword,
                      hintText: "Enter current password",
                      controller: cubit.currentPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) =>
                      value == null || value.isEmpty ? "Required" : null,
                      key: const ValueKey("current_password"),
                      autoFocus: false,
                      isObscure: true,
                      onChanged: (value) {},
                      readOnly: false,
                      suffix: null,
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      labelText: lang.newPassword,
                      hintText: "Enter new password",
                      controller: cubit.newPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) =>
                      value == null || value.isEmpty ? "Required" : null,
                      key: const ValueKey("new_password"),
                      autoFocus: false,
                      isObscure: true,
                      onChanged: (value) {},
                      readOnly: false,
                      suffix: null,
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      labelText: lang.confirmPassword,
                      hintText: "Confirm new password",
                      controller: cubit.confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required";
                        } else if (value != cubit.newPasswordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                      key: const ValueKey("confirm_password"),
                      autoFocus: false,
                      isObscure: true,
                      onChanged: (value) {},
                      readOnly: false,
                      suffix: null,
                    ),
                    const SizedBox(height: 32),
                    state.status == Status.loading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                      onPressed: () {
                        cubit.changePassword();
                      },
                      text: "${lang.changePassword}",
                      backgroundColor: ColorManager.bank,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
