import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/features/forget_password/presentation/view_model/forgot_password_cubit.dart';
import 'package:flower_app/features/forget_password/presentation/view_model/forgot_password_state.dart';
import 'package:flower_app/features/forget_password/presentation/views/forgot_password_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Password'),
        leading: const Icon(CupertinoIcons.back),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Reset password",style: TextStyle(
                fontWeight: FontWeight.w500,fontSize: 18
            ),),
            SizedBox(height: 15.h,),
            const Text(
              "Password must not be empty and must contain 6 characters with upper case letter\n and one number at least ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorManager.grayColor,
                  fontWeight: FontWeight.w400,fontSize: 14
              ),
            ),
            SizedBox(height: 30.h,),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorManager.grayColor
                    )
                ),
                labelText: 'New Password',
                labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.grayColor
                ),
                hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.lighterGrayColor
                ),
                hintText: "Enter your password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorManager.grayColor
                    )
                ),
                labelText: 'Confirm Password',
                labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.grayColor
                ),
                hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.lighterGrayColor
                ),
                hintText: "Confirm Password",
                border: OutlineInputBorder(
                ),
              ),

            ),
            const SizedBox(height: 40),
            BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
              listener: (context, state) {
                if (state is ForgotPasswordError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                } else if (state is ForgotPasswordResetSuccess) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                        (route) => false,
                  );
                }
              },
              builder: (context, state) {
                return state is ForgotPasswordLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                  width: double.infinity,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(ColorManager.primaryColor)
                        ),
                                        onPressed: () {
                      if (passwordController.text != confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Passwords do not match")),
                        );
                      } else {
                        BlocProvider.of<ForgotPasswordCubit>(context)
                            .resetPassword("email@example.com", passwordController.text,context);
                                         }
                                        },
                                        child:const Text('Confirm',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: ColorManager.whiteBaseColor
                                          ),),
                                      ),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
