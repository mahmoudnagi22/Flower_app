
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api_manager/api_manager.dart';

import '../../../../core/api_manager/api_result.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/resources/constants_manager.dart';
import '../../../../core/utils/failures.dart';
import '../auto_login_data_source/auto_login_data_source.dart';

@Injectable(as : AutoLoginDataSource)
class AutoLoginDataSourceImp implements AutoLoginDataSource {
  const AutoLoginDataSourceImp(this._apiManager);

  final ApiManager _apiManager;

  @override
  Future<ApiResult> autoLogin() async {
    try {
      const storage = FlutterSecureStorage();
      final String? token = await storage.read(key: 'user_token');

      if (token == null) {
        return ApiErrorResult(
          failures: CustomError(errorMessage: "Auto login failed",),);
      }

      final response = await _apiManager.getRequest(AppConstants.getUserData,
          headers: {'Authorization': 'Bearer $token '});

      UserModel.instance.setFromJson(response?.data);
      UserModel.instance.token = token;


      return ApiSuccessResult( data: token,);
    } catch (e) {
      return ApiErrorResult(
        failures: CustomError(errorMessage: "Auto login failed",),
      );
    }
  }
}
