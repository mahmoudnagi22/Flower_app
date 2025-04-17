import 'package:dio/dio.dart';
import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/core/api_manager/api_result.dart';

import 'package:flower_app/features/app_sections/add_to_cart/data/model/AddToCaetResponse.dart';

import 'package:flower_app/features/app_sections/add_to_cart/data/model/add_to_cart_parameters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/resources/constants_manager.dart';
import '../../../../../core/utils/failures.dart';
import '../add_to_cart_data_source/add_to_cart_data_source.dart';

class AddToCartDataSourceImpl implements AddToCartDataSource{
  ApiManager apiManager;
  AddToCartDataSourceImpl({required this.apiManager});


  @override
  Future<ApiResult<AddToCartResponse>> addToCart(AddToCartParameters parameters) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(AppConstants.tokenKey);

      if (token == null) {
        return ApiErrorResult(
          failures: AuthError(errorMessage: "You need to login first."),
        );
      }

      final response = await apiManager.postRequest(
        AppConstants.baseUrl + AppConstants.addToCart,
        parameters.toJson(),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response != null && response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return ApiSuccessResult(
          data: AddToCartResponse.fromJson(response.data),
        );
      } else {
        return ApiErrorResult(
          failures: ServerError(errorMessage: _mapServerError(response?.data)),
        );
      }
    } on DioException catch (error) {
      return ApiErrorResult(
        failures: ServerError(errorMessage: error.message ?? 'Unexpected error'),
      );
    }
  }

}

String _mapServerError(dynamic data) {
  if (data is Map && data['error'] != null) {
    switch (data['error']) {
      case 'sold out':
        return 'The product is sold out';
      case 'invalid product':
        return 'This product is no longer available';
    // تقدر تضيف حالات تانية حسب اللي السيرفر ممكن يرجعه
      default:
        return data['error'].toString(); // fallback
    }
  }
  return 'Something went wrong';
}
