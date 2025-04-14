import 'package:flower_app/features/edit_profile/data/data_sources/remote_profile_datasorce_contract.dart';
import 'package:flower_app/features/edit_profile/data/models/user_profile_model.dart';
import 'package:flower_app/features/edit_profile/domain/entities/user_profile_entity.dart';
import 'package:flower_app/features/edit_profile/domain/repositories/profile_repo_contract.dart';

class ProfileRepoImpl extends ProfileRepoContract {
  final RemoteProfileDatasorceContract remoteProfileDatasorceContract;
  ProfileRepoImpl(this.remoteProfileDatasorceContract);

  @override
  Future<UserProfileEntity> updateUserProfile(
    UserProfileEntity userProfile,
    String token,
  ) async {
    return remoteProfileDatasorceContract.updateProfile(
      userProfile as UserProfileModel,
      token,
    );
  }
}
