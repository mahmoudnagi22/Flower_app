import 'package:flower_app/core/models/user_model.dart';
import 'package:flower_app/features/edit_profile/edit_data/data/data_sources/remote_profile_datasorce_contract.dart';
import 'package:flower_app/features/edit_profile/edit_data/domain/repositories/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ProfileRepoContract)
class ProfileRepoImpl extends ProfileRepoContract {
  final RemoteProfileDatasorceContract remoteProfileDatasorceContract;
  ProfileRepoImpl(this.remoteProfileDatasorceContract);

  @override
  Future<UserModel> updateUserProfile(UserModel userModel, String token) async {
    return remoteProfileDatasorceContract.updateProfile(userModel, token);
  }
}
