import 'dart:io';

import 'package:flower_app/core/models/user_model.dart';
import 'package:flower_app/features/edit_profile/domain/use_cases/update_profile_usecase.dart';
import 'package:flower_app/features/edit_profile/presentation/view_model/edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class EditProfileCubit extends Cubit<EditProfileState> {
  final UpdateProfileUsecase updateProfileUsecase;
  EditProfileCubit(this.updateProfileUsecase) : super(EditProfileInitial());

  File? imageFile;
  void pickImage(File file) {
    imageFile = file;
    UserModel.instance.profileImage = file.path;
    emit(EditProfileInitial());
  }

  void updateProfile(UserModel userProfile, String token) async {
    emit(EditProfileLoading());
    try {
      final editUserProfile = await updateProfileUsecase(userProfile, token);
      emit(EditProfileSuccess(editUserProfile));
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }
}
