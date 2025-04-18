import 'package:dio/dio.dart';
import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/core/error/app_exceptions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/models/user_model.dart';
import '../../../../../core/resources/constants_manager.dart';
import '../../../../../core/utils/failures.dart';
import '../datasource_contract/login_datasource.dart';
import '../model/login_user_response.dart';

@Singleton(as: LoginDataSource)
class LoginDataSourceImpl implements LoginDataSource {
  ApiManager apiManager = ApiManager(Dio());

  @override
  Future<ApiResult> login(LoginUserResponse parameters) async {
    try {
      var response = await apiManager.postRequest(
        AppConstants.loginEndPoint,
        parameters.toJson(),
      );

      if (response?.statusCode == 200) {
        UserModel.instance.setFromJson(response?.data);
        if (parameters.rememberMe) {
          const storage = FlutterSecureStorage();
          await storage.write(
            key: 'user_token',
            value: UserModel.instance.token,
          );
        }
        return ApiSuccessResult(data: response?.data);
      } else {
        return ApiErrorResult(
          failures: AuthError(errorMessage: response?.data['error']),
        );
      }
    }on DioException catch (error) {
      return ApiErrorResult(failures: AuthError(errorMessage: error.response?.data["error"]??"Something went wrong"));
    }


    }

}
