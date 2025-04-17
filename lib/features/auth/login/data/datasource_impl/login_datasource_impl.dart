import 'package:dio/dio.dart';
import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/core/error/app_exceptions.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/resources/constants_manager.dart';
import '../datasource_contract/login_datasource.dart';
import '../model/LoginResponse.dart';
import '../model/login_user_response.dart';

@Singleton(as:LoginDataSource )

class LoginDataSourceImpl implements LoginDataSource{
  ApiManager apiManager = ApiManager();


  @override
  Future<LoginResponse> login(LoginUserResponse parameters)async {
  try{
    var response =  await apiManager.dio.post(AppConstants.loginEndPoint ,data: parameters.toJson());
    return LoginResponse.fromJson(response.data);
  }catch (ex){
    String massage = ex.toString();
    if(ex is DioException){
      if (ex.response?.data is Map) {
        massage = ex.response!.data['message'] ?? 'some thing went wrong';
      } else {
        massage = 'something went wrong';
      }
      throw LoginException(massage : massage);
    }
    massage = ex.toString();
    throw AuthException(massage : massage);
  }
  }
  @override
  Future<String?> getToken() async{
    try{
      SharedPreferences sharedPreferences =await  SharedPreferences.getInstance();
      return sharedPreferences.getString(AppConstants.tokenKey);
    }catch(ex){
      throw TokenException(massage: "Not Save Account");

    }
  }

  @override
  Future<void> saveToken(String token)async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      await sharedPreferences.setString(AppConstants.tokenKey, token);
    }catch(ex){
      throw TokenException(massage: "Not Save The Account");
    }
  }
  
}