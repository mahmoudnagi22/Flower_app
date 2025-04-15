import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/core/resources/constants_manager.dart';
import 'package:flower_app/features/edit_profile/data/data_sources/remote_profile_datasorce_contract.dart';
import 'package:flower_app/features/edit_profile/data/models/user_profile_model.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: RemoteProfileDatasorceContract)
class RemoteProfileDatasourceImpl extends RemoteProfileDatasorceContract {
  ApiManager apiManager;
  RemoteProfileDatasourceImpl(this.apiManager);

  @override
  Future<UserProfileModel> updateProfile(
    UserProfileModel userProfile,
    String token,
  ) async {
    final response = await apiManager.putRequest(
      AppConstants.editProfile,
      userProfile.toJson(),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    return UserProfileModel.fromJson(response?.data['data']);
  }
}
