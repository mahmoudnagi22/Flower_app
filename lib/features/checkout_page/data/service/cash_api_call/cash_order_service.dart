import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/core/resources/constants_manager.dart';
import 'package:flower_app/core/utils/failures.dart';
import 'package:flower_app/features/checkout_page/data/dto/cash_dto/requests/order_dto_request.dart';
import 'package:flower_app/features/checkout_page/data/dto/cash_dto/responses/order_dto_response.dart';
import 'package:injectable/injectable.dart';


@singleton
class CashOrderService {
  final ApiManager apiManager;

  CashOrderService({
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

  //TODO:====================== Function IS Checkout page =======
  Future<ApiResult<CashOrderResponseDto>> CashCheckOutMethod(
      CashOrderRequestDto request) async {
    if (!await _isConnected()) {
      return ApiErrorResult(
        failures: NetworkError(
            errorMessage: 'No internet connection available. Please check your network and try again.'),
      );
    }

    try {
      final response = await apiManager.postRequest(
        AppConstants.baseUrl + AppConstants.orders,
        request.toJson(),
      );

      if (response != null && response.statusCode != null) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return ApiSuccessResult(
            data: CashOrderResponseDto.fromJson(response.data),
          );
        } else if (response.statusCode! >= 500) {
          return ApiErrorResult(
            failures: ServerError(
                errorMessage: 'Server error: ${response.data.toString()}'),
          );
        } else {
          return ApiErrorResult(
            failures: ServerError(
                errorMessage: 'Unexpected status code: ${response.statusCode}'),
          );
        }
      } else {
        return ApiErrorResult(
          failures: ServerError(errorMessage: 'No response from server.'),
        );
      }
    } on DioException catch (e) {
      return ApiErrorResult(
        failures: ServerError(
          errorMessage: e.response?.data.toString() ?? e.message ??
              'An unexpected error occurred',
        ),
      );
    }
  }
}