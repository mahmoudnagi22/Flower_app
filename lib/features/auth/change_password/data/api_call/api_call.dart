import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/core/models/user_model.dart';
import 'package:flower_app/core/resources/constants_manager.dart';
import 'package:flower_app/core/utils/failures.dart';
import 'package:flower_app/features/auth/change_password/data/dto/requests/change_password_request_dto.dart';
import 'package:flower_app/features/auth/change_password/data/dto/responses/change_password_response_dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class ChangePasswordService {
  final ApiManager apiManager;

  ChangePasswordService({
    required this.apiManager,
  });
  //TODO:====================== Function IS Connected =======
  Future<bool> _isConnected() async {
    final List<ConnectivityResult> connectivityResult =
    await Connectivity().checkConnectivity();
    return connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.vpn);
  }
  //TODO:====================== Function IS change password =======
  final token = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjdmZDkzNDlhOTgzMmQ4MzU5ZTJjOGU3Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NDUwMjEwNjh9.crVh1rQDz-JskX4XyPYwDy-Rptv1Wt3-yJPHUHbU770';
  Future<ApiResult<ChangePasswordResponseDto>> changePassword(ChangePasswordRequestDto request) async {
    if (!await _isConnected()) {
      return ApiErrorResult(
        failures: NetworkError(errorMessage: 'Please Check your internet'),
      );
    }

    try {
      final response = await apiManager.patchRequest(
        AppConstants.baseUrl + AppConstants.changePasswordEndpoint,
        request.toJson(),
          token: 'Bearer ${UserModel.instance.token}'
      );

      if (response != null && response.statusCode != null) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return ApiSuccessResult(
            data: ChangePasswordResponseDto.fromJson(response.data),
          );
        } else {
          return ApiErrorResult(
            failures: ServerError(errorMessage: response.data.toString()),
          );
        }
      } else {
        return ApiErrorResult(
          failures: ServerError(errorMessage: 'No response from server')
        );
      }
    } on DioException catch (e) {
      return ApiErrorResult(
        failures: ServerError(
          errorMessage: e.message ?? 'An unexpected error occurred',
        ),
      );
    }
  }
}
Future<void> loadSavedUserToken() async {
  const storage = FlutterSecureStorage();
  final savedToken = await storage.read(key: 'user_token');
  if (savedToken != null) {
    UserModel.instance.token = savedToken;
  }
}