import 'dart:developer';

import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/core/routes_manager/route_generator.dart';
import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flower_app/core/utils/dialog_utils.dart';
import 'package:flower_app/core/widget/validators.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/model/login_user_response.dart';
import '../cubit/login_status.dart';
import '../widgets/text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool checkboxState = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        leading: const Icon(Icons.arrow_back_ios_new_outlined),
        title: Text(
          "Login",
          style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: formState,
              child: Column(
                children: [
                  Padding(
                    padding: REdgeInsets.only(top: 8.0),
                    child: BuildTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: email,
                      hintText: "Enter you email",
                      labelText: "Email",
                      validatorMessage: "This Email is not valid",
                      validation: AppValidators.validateEmail,
                    ),
                  ),
                  SizedBox(height: 25.h),
                  BuildTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: password,
                    labelText: "Password",
                    hintText: "Enter you password ",
                    validatorMessage: "Invalid password",
                    validation: AppValidators.validatePassword,
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: checkboxState,
                            onChanged: (value) {
                              setState(() {
                                checkboxState = value!;
                                // if(checkboxState = true){
                                //   sta =CheckGetTokenTrueState ;
                                // }
                              });
                              BlocProvider.of<LoginCubit>(
                                context,
                              ).getToken(checkboxState);
                            },
                          ),
                          //SizedBox(width: 0.w),
                          Text(
                            "Remember me",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: ColorManager.black,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forget password?",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: ColorManager.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 55.h),
                  BlocListener<LoginCubit, LoginCubitState>(
                    listener: (context, state) {
                      if (state is CheckGetTokenTrueState) {
                        Navigator.push(
                          context,
                          RouteGenerator.getRoute(
                            const RouteSettings(name: Routes.bottomNav),
                          ),
                        );
                      } else if (state is CheckGetTokenFalseState == false) {}
                      if (state is LoginLoadingState) {
                        DialogUtils.showLoading(context, 'Loading ...');
                      } else if (state is LoginErrorState) {
                        DialogUtils.hideLoading(context);
                        DialogUtils.showError(context, state.massage);
                      } else if (state is LoginSuccessState) {
                        DialogUtils.hideLoading(context);
                        Navigator.push(
                          context,
                          RouteGenerator.getRoute(
                            RouteSettings(name: Routes.bottomNav),
                          ),
                        );
                      }
                    },
                    child: MaterialButton(
                      elevation: 0,
                      padding: EdgeInsets.only(
                        top: 10.sp,
                        right: 24.sp,
                        bottom: 10.sp,
                        left: 24.sp,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      height: 48.h,
                      minWidth: 343.w,
                      textColor: ColorManager.white,
                      color: ColorManager.bank,
                      onPressed: () {
                        if (formState.currentState!.validate()) {
                          // log("SOFO");
                          BlocProvider.of<LoginCubit>(context).login(
                            LoginUserResponse(
                              email: email.text,
                              password: password.text,
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Login",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  MaterialButton(
                    elevation: 0,
                    padding: EdgeInsets.only(
                      top: 10.sp,
                      right: 24.sp,
                      bottom: 10.sp,
                      left: 24.sp,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: ColorManager.gray, width: 1.5),
                    ),
                    height: 48.h,
                    minWidth: 343.w,
                    textColor: ColorManager.gray,
                    color: ColorManager.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        RouteGenerator.getRoute(
                          RouteSettings(name: Routes.bottomNav),
                        ),
                      );
                    },
                    child: Text(
                      "Continue as guest",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        // color: ColorManager.gray,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: ColorManager.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.registerRoute,
                          );
                          // push(
                          //   context,
                          //   RouteGenerator.getRoute(
                          //     RouteSettings(name: Routes.registerRoute),
                          //   ),
                          // );
                        },
                        child: Text(
                          "Sign up",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: ColorManager.bank,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
