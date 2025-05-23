import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/change_password/presentation/cubit/change_password_state.dart';
import 'package:flower_app/features/auth/signUp/domain/entities/signup_request_entity.dart';
import 'package:flower_app/features/auth/signUp/domain/entities/signup_response_entity.dart';
import 'package:flower_app/features/auth/signUp/domain/use_cases/signup_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
part 'signup_state.dart';

@injectable
class SignupCubit extends Cubit<SignupState> {
  SignupCubit({required this.signupUseCase}) : super(const SignupState());

  SignupUseCase signupUseCase;

  final TextEditingController genderMaleController = TextEditingController();
  final TextEditingController genderFemaleController = TextEditingController();
  final TextEditingController genderController =
      TextEditingController(text: 'male');
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController(text: '+20');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isObscurePassword = true;

  bool isObscureConfirmPassword = true;

  void signup() async {
    emit(state.copyWith(signupState: Status.loading));
    final signup = SignupRequestEntity(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      password: passwordController.text,
      rePassword: rePasswordController.text,
      phone: phoneController.text,
      gender: genderController.text,
    );
    ApiResult<SignupResponseEntity> result = await signupUseCase.call(signup);
    switch (result) {
      case ApiSuccessResult<SignupResponseEntity>():
        emit(state.copyWith(
            signupList: result.data, signupState: Status.success));
      case ApiErrorResult<SignupResponseEntity>():
        emit(state.copyWith(
            signupError: result.failures.errorMessage,
            signupState: Status.error));
    }
  }
}
