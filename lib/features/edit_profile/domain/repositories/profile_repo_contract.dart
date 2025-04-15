import 'package:flower_app/features/edit_profile/domain/entities/user_profile_entity.dart';

abstract class ProfileRepoContract {
  Future<UserProfileEntity> updateUserProfile(
    UserProfileEntity userProfile,
    String token,
  );
}
