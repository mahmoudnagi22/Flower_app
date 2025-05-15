import 'package:flower_app/core/models/user_model.dart';
import 'package:flower_app/features/edit_profile/domain/repositories/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateProfileUsecase {
  final EditProfileRepoContract profileRepoContract;
  UpdateProfileUsecase(this.profileRepoContract);

  Future<UserModel> call(UserModel userModel, String token) {
    return profileRepoContract.updateUserProfile(userModel, token);
  }
}
