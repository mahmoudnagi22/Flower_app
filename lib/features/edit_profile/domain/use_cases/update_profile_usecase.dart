import 'package:flower_app/features/edit_profile/domain/entities/user_profile_entity.dart';
import 'package:flower_app/features/edit_profile/domain/repositories/profile_repo_contract.dart';

class UpdateProfileUsecase {
  final ProfileRepoContract profileRepoContract;
  UpdateProfileUsecase(this.profileRepoContract);

  Future<void> call(UserProfileEntity userProfile) {
    return profileRepoContract.updateUserProfile(userProfile);
  }
}
