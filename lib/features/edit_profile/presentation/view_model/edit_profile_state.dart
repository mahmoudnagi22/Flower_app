import 'package:flower_app/features/edit_profile/domain/entities/user_profile_entity.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  final UserProfileEntity userProfileEntity;
  EditProfileSuccess(this.userProfileEntity);
}

class EditProfileError extends EditProfileState {
  final String message;
  EditProfileError(this.message);
}
