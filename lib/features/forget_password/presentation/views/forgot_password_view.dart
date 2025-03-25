import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/features/forget_password/presentation/view_model/forgot_password_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Password'),
      leading: const Icon(CupertinoIcons.back),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text("Forget password",style: TextStyle(
                fontWeight: FontWeight.w500,fontSize: 18
              ),),
              SizedBox(height: 15.h,),
              const Text(
                  "Please enter your email associated to\n your account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorManager.grayColor,
                  fontWeight: FontWeight.w400,fontSize: 14
                ),
              ),
              SizedBox(height: 30.h,),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                    labelText: 'Email',
                labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.grayColor
                ),
                hintText: 'Enter your email',
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ColorManager.lightGrayColor
                ),
                border: OutlineInputBorder(
                ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorManager.grayColor
                        )
                    )
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(ColorManager.primaryColor)
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final email = _emailController.text.trim();
                      context.read<ForgotPasswordCubit>().sendResetEmail(email,context);
                    }

                  },
                  child: const Text('Confirm',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.whiteBaseColor
                  ),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
