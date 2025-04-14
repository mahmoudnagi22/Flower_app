import 'package:flower_app/features/edit_profile/data/models/user_profile_model.dart';

abstract class RemoteProfileDatasorceContract {
  Future<UserProfileModel> updateProfile(
    UserProfileModel userProfile,
    String token,
  );
}
