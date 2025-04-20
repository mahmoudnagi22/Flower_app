import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/core/resources/constants_manager.dart';
import 'package:flower_app/features/edit_profile/data/data_sources/change_pass_ds_contract.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ChangePassDsContract)
class ChangePassDsImpl implements ChangePassDsContract {
  final ApiManager apiManager;
  ChangePassDsImpl(this.apiManager);

  @override
  Future<void> changePassword({
    required String token,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final response = apiManager.postRequest(
        AppConstants.changePassword,
        {"password": currentPassword, "newPassword": newPassword},
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
    } catch (e) {
      throw Exception('Failed to change password');
    }
  }
}
