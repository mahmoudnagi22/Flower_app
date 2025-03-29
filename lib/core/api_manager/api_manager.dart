import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import '../resources/constants_manager.dart';

// @singleton
class ApiManager {

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrlAuth,
    )
  );

  // TODO : =================== GetRequest ==============
  Future<Response?> getRequest(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await dio.get(endpoint, queryParameters: queryParameters);
      return response;
    } on DioException catch (error) {
      print("Get Error: " '${error.message}');
      return null;
    }
  }

  // TODO : =================== PostRequest ==============

  Future<Response?> postRequest(String endpoint, dynamic data, {Map<String, String>? headers}) async {
    try {
      Response response = await dio.post(endpoint, data: data, options: Options(headers: headers));
      return response;
    } on DioException catch (error) {
      print("Post Error: " '${error.message}');
      return null;
    }
  }

  // TODO : =================== PutRequest ==============
  Future<Response?> putRequest(String endpoint, dynamic data, {Map<String, String>? headers}) async {
    try {
      Response response = await dio.put(endpoint, data: data, options: Options(headers: headers));
      return response;
    } on DioException catch (error) {
      print("Put Error: " '${error.message}');
      return null;
    }
  }

// TODO : =================== PatchRequest ==============
  Future<Response?> patchRequest(String endpoint, dynamic data, {Map<String, String>? headers}) async {
    try {
      Response response = await dio.patch(endpoint, data: data, options: Options(headers: headers));
      return response;
    }  on DioException catch (error) {
      print("Patch Error: " '${error.message}');
      return null;
    }
  }

  // TODO : =================== DeleteRequest ==============
  Future<Response?> deleteRequest(String endpoint, {Map<String, String>? headers}) async {
    try {
      Response response = await dio.delete(endpoint, options: Options(headers: headers));
      return response;
    }  on DioException catch (error) {
      print("Delete Error: " '${error.message}');
      return null;
    }
  }



//TODO:====================== Function IS Connected =======
  Future<bool> _isConnected() async {
    final List<ConnectivityResult> connectivityResult =
    await Connectivity().checkConnectivity();
    return connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi);
  }


}