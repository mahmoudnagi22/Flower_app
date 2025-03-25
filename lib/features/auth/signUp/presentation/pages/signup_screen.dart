import 'package:flower_app/core/widget/validators.dart';
import 'package:flower_app/features/auth/signUp/presentation/widgets/custom_button.dart';
import 'package:flower_app/features/auth/signUp/presentation/widgets/custom_text.dart';
import 'package:flower_app/features/login/presentation/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/di/di.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/utils/dialog_utils.dart';
import '../../../../../core/utils/status.dart';
import '../cubit/signup_cubit.dart';
import '../widgets/custom_form_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignupCubit>(),
      child: Builder(
        builder: (context) {
          final viewModel = context.read<SignupCubit>();

          return Scaffold(
            appBar: AppBar(title: const Text("Register")),
            body: BlocListener<SignupCubit, SignupState>(
              listener: (context, state) {
                if (state.signupState == Status.loading) {
                  DialogUtils.showLoading(context, 'Loading ...');
                } else {
                  DialogUtils.hideLoading(context);
                  if (state.signupState == Status.error) {
                    DialogUtils.showError(context, state.signupError ?? '');
                  } else if (state.signupState == Status.success) {
                    DialogUtils.showSuccess(
                        context, "Operation completed successfully");
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ));
                  }
                }
              },
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Form(
                  key: viewModel.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                  readOnly: false,
                                  controller: viewModel.firstNameController,
                                  labelText: "First Name",
                                  hintText: "Enter first name",
                                  keyboardType: TextInputType.text,
                                  validator: (value) =>
                                      AppValidators.validateFullName(value)),
                            ),
                            10.horizontalSpace,
                            Expanded(
                              child: CustomTextFormField(
                                  readOnly: false,
                                  controller: viewModel.lastNameController,
                                  labelText: "Last Name",
                                  hintText: "Enter last name",
                                  keyboardType: TextInputType.text,
                                  validator: (value) =>
                                      AppValidators.validateFullName(value)),
                            ),
                          ],
                        ),
                        15.verticalSpace,
                        CustomTextFormField(
                            readOnly: false,
                            controller: viewModel.emailController,
                            labelText: "Email",
                            hintText: "Enter your Email",
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                AppValidators.validateEmail(value)),
                        15.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                  readOnly: false,
                                  controller: viewModel.passwordController,
                                  labelText: "Password",
                                  hintText: "Enter Password",
                                  isObscure: viewModel.isObscurePassword,
                                  keyboardType: TextInputType.visiblePassword,
                                  icon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        viewModel.isObscurePassword =
                                            !viewModel.isObscurePassword;
                                      });
                                    },
                                    icon: Icon(
                                      viewModel.isObscurePassword
                                          ? Icons.visibility_off_rounded
                                          : Icons.visibility_rounded,
                                    ),
                                  ),
                                  validator: (value) =>
                                      AppValidators.validatePassword(value)),
                            ),
                            10.horizontalSpace,
                            Expanded(
                              child: CustomTextFormField(
                                readOnly: false,
                                controller: viewModel.rePasswordController,
                                labelText: "Confirm password",
                                hintText: "Confirm password",
                                keyboardType: TextInputType.visiblePassword,
                                validator: (value) {
                                  AppValidators.validateConfirmPassword(
                                      value, viewModel.passwordController.text);
                                },
                                isObscure: viewModel.isObscureConfirmPassword,
                                icon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      viewModel.isObscureConfirmPassword =
                                          !viewModel.isObscureConfirmPassword;
                                    });
                                  },
                                  icon: Icon(
                                    viewModel.isObscureConfirmPassword
                                        ? Icons.visibility_off_rounded
                                        : Icons.visibility_rounded,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        15.verticalSpace,
                        CustomTextFormField(
                            readOnly: false,
                            controller: viewModel.phoneController,
                            labelText: "Phone number",
                            hintText: "Enter your Phone number",
                            keyboardType: TextInputType.phone,
                            validator: (value) =>
                                AppValidators.validatePhoneNumber(value)),
                        20.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Gender:',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Color(0xff535353),
                              ),
                            ),
                            SizedBox(width: 20.w),
                            IntrinsicWidth(
                              child: Row(
                                children: [
                                  Radio<String>(
                                    activeColor: ColorManager.appColor,
                                    value: "male",
                                    groupValue: viewModel.genderController.text,
                                    onChanged: (value) {
                                      setState(() {
                                        viewModel.genderController.text =
                                            value!;
                                      });
                                    },
                                  ),
                                  const Text("Male",
                                      style: TextStyle(fontSize: 16)),
                                  SizedBox(width: 20.w),
                                  Radio<String>(
                                    activeColor: ColorManager.appColor,
                                    value: "female",
                                    groupValue: viewModel.genderController.text,
                                    onChanged: (value) {
                                      setState(() {
                                        viewModel.genderController.text =
                                            value!;
                                      });
                                    },
                                  ),
                                  const Text("Female",
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        20.verticalSpace,
                        const Row(
                          children: [
                            Text(
                              'Creating an account, you agree to our ',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'Terms&Conditions',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.black,
                                  decorationThickness: 3,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            )
                          ],
                        ),
                        30.verticalSpace,
                        CustomButton(
                            onPressed: () {
                              if (viewModel.formKey.currentState!.validate()) {
                                viewModel.signup();
                                //TODO: Navigator to home page
                              }
                            },
                            text: 'Sign Up'),
                        15.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(fontSize: 16),
                            ),
                            CustomText(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Login(),
                                    ));
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2,
                                    decorationColor: ColorManager.appColor,
                                    color: ColorManager.appColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
