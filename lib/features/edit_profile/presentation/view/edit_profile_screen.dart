import 'dart:io';

import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/models/user_model.dart';
import 'package:flower_app/core/resources/color_manager.dart';
import 'package:flower_app/core/widget/validators.dart';
import 'package:flower_app/features/auth/signUp/presentation/widgets/custom_button.dart';
import 'package:flower_app/features/auth/signUp/presentation/widgets/custom_form_field.dart';
import 'package:flower_app/features/edit_profile/presentation/view_model/edit_profile_cubit.dart';
import 'package:flower_app/features/edit_profile/presentation/view_model/edit_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();

  bool isObscurePassword = true;
  bool isObscureConfirmPassword = true;
  late String gender;

  @override
  void initState() {
    super.initState();
    final user = widget.userModel;
    firstNameController = TextEditingController(text: user.firstName);
    lastNameController = TextEditingController(text: user.lastName);
    emailController = TextEditingController(text: user.email);
    phoneController = TextEditingController(text: user.phoneNumber);
    passwordController = TextEditingController(text: "**********");
    gender = user.gender ?? 'female';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EditProfileCubit>(),
      child: Builder(
        builder: (context) {
          final viewModel = context.read<EditProfileCubit>();

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
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
                            CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 6,
                            ),
                            Text(
                              '3',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            body: BlocConsumer<EditProfileCubit, EditProfileState>(
              listener: (context, state) {
                if (state is EditProfileSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile updated successfully!'),
                    ),
                  );
                } else if (state is EditProfileError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 40.r,
                                backgroundImage:
                                    viewModel.imageFile != null
                                        ? FileImage(viewModel.imageFile!)
                                        : (widget.userModel.profileImage != null
                                                ? NetworkImage(
                                                  widget
                                                          .userModel
                                                          .profileImage ??
                                                      '',
                                                )
                                                : const AssetImage(
                                                  'assets/images/user.png',
                                                ))
                                            as ImageProvider,
                              ),
                              InkWell(
                                onTap: () async {
                                  final pickedFile = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  if (pickedFile != null) {
                                    viewModel.pickImage(File(pickedFile.path));
                                  }
                                },
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
                                  keyboardType: TextInputType.text,
                                  validator:
                                      (value) =>
                                          AppValidators.validateFullName(value),
                                ),
                              ),
                              10.horizontalSpace,
                              Expanded(
                                child: CustomTextFormField(
                                  readOnly: false,
                                  controller: lastNameController,
                                  labelText: "Last Name",
                                  keyboardType: TextInputType.text,
                                  validator:
                                      (value) =>
                                          AppValidators.validateFullName(value),
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
                            validator:
                                (value) => AppValidators.validateEmail(value),
                          ),
                          15.verticalSpace,
                          CustomTextFormField(
                            readOnly: false,
                            controller: phoneController,
                            labelText: "Phone number",
                            keyboardType: TextInputType.phone,
                            validator:
                                (value) =>
                                    AppValidators.validatePhoneNumber(value),
                          ),
                          15.verticalSpace,
                          CustomTextFormField(
                            readOnly: false,
                            controller: passwordController,
                            labelText: "Password",
                            isObscure: isObscurePassword,
                            keyboardType: TextInputType.visiblePassword,
                            suffix: InkWell(
                              onTap: () {
                                viewModel.changePassword(
                                  token: UserModel.instance.token!,
                                  currentPassword: "*********",
                                  newPassword: passwordController.text.trim(),
                                );
                              },
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
                            validator:
                                (value) =>
                                    AppValidators.validatePassword(value),
                          ),
                          15.verticalSpace,
                          IntrinsicWidth(
                            child: Row(
                              children: [
                                const Text(
                                  'Gender',
                                  style: TextStyle(fontSize: 18),
                                ),
                                20.horizontalSpace,
                                Radio<String>(
                                  activeColor: ColorManager.appColor,
                                  value: "female",
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value!;
                                    });
                                  },
                                ),
                                const Text(
                                  'Female',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(width: 20.w),
                                Radio<String>(
                                  activeColor: ColorManager.appColor,
                                  value: "male",
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value!;
                                    });
                                  },
                                ),
                                const Text(
                                  'Male',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),

                          // 15.verticalSpace,
                          CustomButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                final updatedUser =
                                    UserModel.instance
                                      ..firstName =
                                          firstNameController.text.trim()
                                      ..lastName =
                                          lastNameController.text.trim()
                                      ..email = emailController.text.trim()
                                      ..phoneNumber =
                                          phoneController.text.trim()
                                      ..gender = gender;
                                viewModel.updateProfile(
                                  updatedUser,
                                  UserModel.instance.token!,
                                );
                                Navigator.pop(context);
                              }
                            },
                            text: 'Update',
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
