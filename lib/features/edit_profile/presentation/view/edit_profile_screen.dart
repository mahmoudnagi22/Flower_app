import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/core/widget/validators.dart';
import 'package:flower_app/features/auth/signUp/presentation/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController(text: '+20');

  bool isObscurePassword = true;
  bool isObscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text(
          'Edit profile',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.sp),
            child: InkWell(
              onTap: () {},
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.asset('assets/images/notification.png'),
                  const Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(backgroundColor: Colors.red, radius: 6),
                      Text(
                        '3',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 40.r,
                    backgroundImage: const NetworkImage(
                      'https://images.unsplash.com/photo-1575936123452-b67c3203c357?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset('assets/images/Camera.png'),
                  ),
                ],
              ),
              15.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      readOnly: false,
                      controller: firstNameController,
                      labelText: "First Name",
                      hintText: "Enter first name",
                      keyboardType: TextInputType.text,
                      validator:
                          (value) => AppValidators.validateFullName(value),
                    ),
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: CustomTextFormField(
                      readOnly: false,
                      controller: lastNameController,
                      labelText: "Last Name",
                      hintText: "Enter last name",
                      keyboardType: TextInputType.text,
                      validator:
                          (value) => AppValidators.validateFullName(value),
                    ),
                  ),
                  10.verticalSpace,
                ],
              ),
              15.verticalSpace,
              CustomTextFormField(
                readOnly: false,
                controller: emailController,
                labelText: "Email",
                keyboardType: TextInputType.emailAddress,
                validator: (value) => AppValidators.validateEmail(value),
              ),
              15.verticalSpace,
              CustomTextFormField(
                readOnly: false,
                controller: phoneController,
                labelText: "Phone number",
                hintText: "Enter your Phone number",
                keyboardType: TextInputType.phone,
                validator: (value) => AppValidators.validatePhoneNumber(value),
              ),
              15.verticalSpace,
              CustomTextFormField(
                readOnly: false,
                controller: passwordController,
                labelText: "Password",
                hintText: "Enter Password",
                isObscure: isObscurePassword,
                keyboardType: TextInputType.visiblePassword,
                suffix: InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Text(
                      'Change',
                      style: TextStyle(
                        color: ColorManager.appColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                validator: (value) => AppValidators.validatePassword(value),
              ),
              15.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
