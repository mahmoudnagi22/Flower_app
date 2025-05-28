import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/core/resources/constants_manager.dart' ;
import 'package:flower_app/features/app_sections/best_seller/data/models/best_seller_dto.dart';
import 'package:flower_app/core/utils/failures.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/api_manager/api_manager.dart';

@singleton
class BestSellerApiCall {
  final ApiManager _apiManager;

  BestSellerApiCall(this._apiManager);

  Future<ApiResult<List<BestSellerDto>>> getBestSeller() async {
    if (!await _apiManager.isConnected()) {
      return ApiErrorResult(
        failures: NetworkError(errorMessage: 'Please Check your internet'),
      );
    }
    try {
      final response = await _apiManager.getRequest(
        AppConstants.baseUrl + AppConstants.bestSeller,
      );

      if (response != null && response.statusCode != null) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final List<dynamic> result = response.data['bestSeller'] ?? [];
          final List<BestSellerDto> bestSellerDto =
          result.map((json) => BestSellerDto.fromJson(json)).toList();
          return ApiSuccessResult(data: bestSellerDto);
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
