import 'package:dio/dio.dart';
import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/core/resources/constants_manager.dart';
import 'package:flower_app/core/utils/failures.dart';
import 'package:flower_app/features/auth/forgot_password/data/dto/request_dto/forgot_password_request_dto.dart';
import 'package:flower_app/features/auth/forgot_password/data/dto/request_dto/reset_password_request_dto.dart';
import 'package:flower_app/features/auth/forgot_password/data/dto/request_dto/verify_reset_password_request_dto.dart';
import 'package:flower_app/features/auth/forgot_password/data/dto/response_dto/forgot_password_response_dto.dart';
import 'package:flower_app/features/auth/forgot_password/data/dto/response_dto/reset_password_response_dto.dart';
import 'package:flower_app/features/auth/forgot_password/data/dto/response_dto/verify_reset_password_response_dto.dart';
import 'package:injectable/injectable.dart';

@singleton
class ForgotPasswordService {
  final ApiManager apiManager;

  ForgotPasswordService({required this.apiManager});

  //! ====================== Function IS forgotPassword =======
  Future<ApiResult<ForgotPasswordResponseDto>> forgotPassword(
    ForgotPasswordRequestDto request,
  ) async {
    if (!await apiManager.isConnected()) {
      return ApiErrorResult(
        failures: NetworkError(errorMessage: 'Please Check your internet'),
      );
    }

    try {
      final response = await apiManager.postRequest(
        AppConstants.baseUrl + AppConstants.forgotPassword,
        request.toJson(),
      );

      if (response != null && response.statusCode != null) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return ApiSuccessResult(
            data: ForgotPasswordResponseDto.fromJson(response.data),
          );
        } else {
          return ApiErrorResult(
            failures: ServerError(errorMessage: response.data.toString()),
          );
        }
      } else {
        return ApiErrorResult(
          failures: ServerError(errorMessage: 'No response from server'),
        );
      }
    } on DioException catch (e) {
      return ApiErrorResult(
        failures: ServerError(
          errorMessage: e.message ?? 'An unexpected error occurred',
        ),
      );
    }
  } //!====================== Function IS resetPassword =======

  Future<ApiResult<ResetPasswordResponseDto>> resetPassword(
    ResetPasswordRequestDto request,
  ) async {
    if (!await apiManager.isConnected()) {
      return ApiErrorResult(
        failures: NetworkError(errorMessage: 'Please Check your internet'),
      );
    }

    try {
      final response = await apiManager.putRequest(
        AppConstants.baseUrl + AppConstants.resetPassword,
        request.toJson(),
      );

      if (response != null && response.statusCode != null) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return ApiSuccessResult(
            data: ResetPasswordResponseDto.fromJson(response.data),
          );
        } else {
          return ApiErrorResult(
            failures: ServerError(errorMessage: response.data.toString()),
          );
        }
      } else {
        return ApiErrorResult(
          failures: ServerError(errorMessage: 'No response from server'),
        );
      }
    } on DioException catch (e) {
      return ApiErrorResult(
        failures: ServerError(
          errorMessage: e.message ?? 'An unexpected error occurred',
        ),
      );
    }
  } //!====================== Function IS verifyCode =======

  Future<ApiResult<ResetCodeResponseDto>> verifyCode(
    ResetCodeRequestDto request,
  ) async {
    if (!await apiManager.isConnected()) {
      return ApiErrorResult(
        failures: NetworkError(errorMessage: 'Please Check your internet'),
      );
    }

    try {
      final response = await apiManager.postRequest(
        AppConstants.baseUrl + AppConstants.verifyResetCode,
        request.toJson(),
      );

      if (response != null && response.statusCode != null) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return ApiSuccessResult(
            data: ResetCodeResponseDto.fromJson(response.data),
          );
        } else {
          return ApiErrorResult(
            failures: ServerError(errorMessage: response.data.toString()),
          );
        }
      } else {
        return ApiErrorResult(
          failures: ServerError(errorMessage: 'No response from server'),
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
