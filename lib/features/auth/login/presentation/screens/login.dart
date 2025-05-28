import 'package:flower_app/core/l10n/app_localizations.dart';
import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/core/routes_manager/route_generator.dart';
import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flower_app/core/utils/dialog_utils.dart';
import 'package:flower_app/core/widget/validators.dart';
import 'package:flower_app/features/auth/login/data/model/login_user_response.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_status.dart';
import 'package:flower_app/features/auth/login/presentation/widgets/text_field.dart';
import 'package:flower_app/features/auth/signUp/presentation/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool checkboxState = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    LoginCubit loginCubit = LoginCubit.get(context);

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          lang.login,
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
                  CustomTextFormField(
                    labelText: lang.email,
                    hintText: lang.enterEmail,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: AppValidators.validateEmail,
                    autoFocus: false,
                    isObscure: false,
                    onChanged: (value) {},
                    readOnly: false,
                    suffix: null,
                  ),
                  SizedBox(height: 25.h),
                  CustomTextFormField(
                    labelText: lang.password,
                    hintText: lang.enterPassword,
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    validator: AppValidators.validatePassword,
                    autoFocus: false,
                    isObscure: true,
                    onChanged: (value) {},
                    readOnly: false,
                    suffix: null,
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: ColorManager.appColor,
                            value: checkboxState,
                            onChanged: (value) {
                              setState(() {
                                checkboxState = value!;
                              });
                            },
                          ),
                          Text(
                            lang.rememberMe,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: ColorManager.black,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          // ضع هنا وظيفة "نسيت كلمة المرور"
                        },
                        child: Text(
                          lang.forgetPassword,
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
                      if (state is LoginLoadingState) {
                        DialogUtils.showLoading(context, lang.loading);
                      } else if (state is LoginErrorState) {
                        DialogUtils.hideLoading(context);
                        DialogUtils.showError(context, state.massage);
                      } else if (state is LoginSuccessState) {
                        DialogUtils.hideLoading(context);
                        Navigator.pushReplacementNamed(context, Routes.bottomNav);
                      }
                    },
                    child: MaterialButton(
                      elevation: 0,
                      padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 10.sp),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      height: 48.h,
                      minWidth: 343.w,
                      color: ColorManager.bank,
                      textColor: ColorManager.white,
                      onPressed: () {
                        if (formState.currentState!.validate()) {
                          loginCubit.login(
                            LoginUserResponse(
                              email: emailController.text,
                              password: passwordController.text,
                              rememberMe: checkboxState,
                            ),
                          );
                        }
                      },
                      child: Text(
                        lang.login,
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
                    padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 10.sp),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: ColorManager.gray, width: 1.5),
                    ),
                    height: 48.h,
                    minWidth: 343.w,
                    color: ColorManager.white,
                    textColor: ColorManager.gray,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.bottomNav);
                    },
                    child: Text(
                      lang.continueAsGuest,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        lang.dontHaveAccount,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: ColorManager.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Routes.registerRoute);
                        },
                        child: Text(
                          lang.signUp,
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
