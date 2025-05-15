import 'dart:io';

import 'package:flower_app/core/models/user_model.dart';
import 'package:flower_app/features/edit_profile/domain/use_cases/change_pass_usecase.dart';
import 'package:flower_app/features/edit_profile/domain/use_cases/update_profile_usecase.dart';
import 'package:flower_app/features/edit_profile/presentation/view_model/edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';


class EditProfileCubit extends Cubit<EditProfileState> {
  final UpdateProfileUsecase updateProfileUsecase;
  final ChangePassUsecase changePassUsecase;
  EditProfileCubit(this.updateProfileUsecase, this.changePassUsecase)
    : super(EditProfileInitial());

  File? imageFile;
  void pickImage(File file) {
    imageFile = file;
    UserModel.instance.profileImage = file.path;
    emit(EditProfileInitial());
  }

  void updateProfile(UserModel userProfile, String token) async {
    if (isClosed) return;
    emit(EditProfileLoading());
    try {
      final editUserProfile = await updateProfileUsecase(userProfile, token);
      if (!isClosed) emit(EditProfileSuccess(editUserProfile));
    } catch (e) {
      if (!isClosed) emit(EditProfileError(e.toString()));
    }
  }

  void changePassword({
    required String token,
    required String currentPassword,
    required String newPassword,
  }) async {
    if (isClosed) return;

    emit(ChangePassLoading());
    try {
      await changePassUsecase(
        token: token,
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      if (!isClosed) emit(ChangePassSuccess());
    } catch (e) {
      if (!isClosed) emit(ChangePassError(e.toString()));
    }
  }
}
