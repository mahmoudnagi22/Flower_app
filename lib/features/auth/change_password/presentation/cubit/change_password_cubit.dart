import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/auth/change_password/domain/entity/request_model_entity/change_password_reqest_enitiy.dart';
import 'package:flower_app/features/auth/change_password/domain/entity/response_model_eintity/change_password_response_enitity.dart';
import 'package:flower_app/features/auth/change_password/domain/use_case/change_password_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'change_password_state.dart';
@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({required this.changePasswordUseCase})
      : super(const ChangePasswordState(status: Status.initial));

  final ChangePasswordUseCase changePasswordUseCase;

  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void changePassword() async {
    if (!formKey.currentState!.validate()) return;

    emit(state.copyWith(status: Status.loading));

    final updatePassword = ChangePasswordRequest(
      password: currentPasswordController.text,
      newPassword: newPasswordController.text,
    );

    ApiResult<ChangePasswordResponse> result = await changePasswordUseCase(updatePassword);

    switch (result) {
      case ApiSuccessResult<ChangePasswordResponse>():
        emit(state.copyWith(
          status: Status.success,
          message: "Password changed successfully",
        ));
      case ApiErrorResult<ChangePasswordResponse>():
        emit(state.copyWith(
          status: Status.error,
          message: result.failures.errorMessage,
        ));
    }
  }

  @override
  Future<void> close() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    return super.close();
  }
}
