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

  //TODO:====================== Function IS change password =======
  Future<ApiResult<ChangePasswordResponseDto>> changePassword(ChangePasswordRequestDto request) async {
    if (!await apiManager.isConnected()) {
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