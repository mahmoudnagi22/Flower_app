import 'package:flower_app/features/edit_profile/domain/entities/user_profile_entity.dart';
import 'package:flower_app/features/edit_profile/domain/repositories/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateProfileUsecase {
  final ProfileRepoContract profileRepoContract;
  UpdateProfileUsecase(this.profileRepoContract);

  Future<UserProfileEntity> call(UserProfileEntity userProfile, String token) {
    return profileRepoContract.updateUserProfile(userProfile, token);
  }
}
