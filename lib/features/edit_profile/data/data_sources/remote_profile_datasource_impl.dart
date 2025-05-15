import 'package:dio/dio.dart';
import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/core/models/user_model.dart';
import 'package:flower_app/core/resources/constants_manager.dart';
import 'package:flower_app/features/edit_profile/data/data_sources/remote_profile_datasorce_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteProfileDatasorceContract)
class RemoteProfileDatasourceImpl extends RemoteProfileDatasorceContract {
  ApiManager apiManager;
  RemoteProfileDatasourceImpl(this.apiManager);

  @override
  Future<UserModel> updateProfile(UserModel userModel, String token) async {
    try {
      FormData formData = FormData.fromMap({
        "firstName": userModel.firstName,
        "lastName": userModel.lastName,
        "email": userModel.email,
        "phone": userModel.phoneNumber,
        "gender": userModel.gender,
        if (userModel.profileImage != null &&
            userModel.profileImage!.isNotEmpty)
          "photo": await MultipartFile.fromFile(
            userModel.profileImage!,
            filename: userModel.profileImage!.split('/').last,
          ),
      });
      final response = await apiManager.putRequest(
        AppConstants.editProfile,
        formData,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      UserModel.instance.setFromJson(response!.data);
      return UserModel.instance;
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
}
