import 'package:flowers_app/core/api_manager/api_constants.dart';
import 'package:flowers_app/core/api_manager/api_execute.dart';
import 'package:flowers_app/core/models/result.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api_manager/api_manger.dart';
import '../../../../core/exceptions/exceptions_impl.dart';
import '../../../../core/models/user_model.dart';
import '../auto_login_data_source/auto_login_data_source.dart';

@Injectable(as : AutoLoginDataSource)
class AutoLoginDataSourceImp implements AutoLoginDataSource {
  const AutoLoginDataSourceImp(this._apiManager);

  final ApiManager _apiManager;

  @override
  Future<Result> autoLogin() async {
    try {
      const storage = FlutterSecureStorage();
      final String? token = await storage.read(key: 'user_token');

      if (token == null) {
        return Error(CustomException("Auto login failed"));
      }

      await ApiExecute.executeApi(
        () async {
          final response = await _apiManager.get(ApiConstants.getUserData,
              headers: {'Authorization': 'Bearer $token '});

          UserModel.instance.setFromJson(response.data);
          UserModel.instance.token = token;
        },
      );

      return Success(token);
    } catch (e) {
      return Error(
        CustomException("Auto login failed"),
      );
    }
  }
}
