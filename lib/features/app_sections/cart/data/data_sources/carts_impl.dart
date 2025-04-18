import 'package:dio/dio.dart';
import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/features/app_sections/cart/data/data_sources/carts_contract.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_response_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/models/api_result.dart';
import '../../../../../core/utils/failures.dart';

@Injectable(as: CartsContract)
class CartsImpl implements CartsContract {
  ApiManager apiManager;

  CartsImpl({required this.apiManager});

  @override
  Future<ApiResult<List<ProductEntity>>> updateQuantity(
    String cartId,
    int quantity,
  ) async {
    try {
      var response = await apiManager.updateQuantity(cartId, quantity);
      return response;
    } on DioException catch (e) {
      return ApiErrorResult(
        failures: NetworkError(
          errorMessage: e.message ?? 'An unexpected error occurred',
        ),
      );
    }
  }

  @override
  Future<ApiResult<List<CartItemsEntity>>> getCarts() async {
    try {
      var response = await apiManager.getCartsItem();
      return response;
    } on DioException catch (e) {
      return ApiErrorResult(failures: NetworkError(
          errorMessage: e.message ?? 'An unexpected error occurred'));
    }
  }

  @override
  Future<ApiResult<List<ProductEntity>>> deleteCart(String cartId) async{
    try {
      var response = await apiManager.deleteCart(cartId);
      return response;
    } on DioException catch (e) {
      return ApiErrorResult(failures: NetworkError(
          errorMessage: e.message ?? 'An unexpected error occurred'));
    }
  }
}
