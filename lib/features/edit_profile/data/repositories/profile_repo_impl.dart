import 'package:flower_app/core/models/user_model.dart';
import 'package:flower_app/features/edit_profile/data/data_sources/remote_profile_datasorce_contract.dart';
import 'package:flower_app/features/edit_profile/domain/repositories/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: EditProfileRepoContract)
class ProfileRepoImpl extends EditProfileRepoContract {
  final RemoteProfileDatasorceContract remoteProfileDatasorceContract;
  ProfileRepoImpl(this.remoteProfileDatasorceContract);

  @override
  Future<UserModel> updateUserProfile(UserModel userModel, String token) async {
    return remoteProfileDatasorceContract.updateProfile(userModel, token);
  }
}
