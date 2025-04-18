import 'package:flower_app/core/models/user_model.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  final UserModel userProfileEntity;
  EditProfileSuccess(this.userProfileEntity);
}

class EditProfileError extends EditProfileState {
  final String message;
  EditProfileError(this.message);
}
