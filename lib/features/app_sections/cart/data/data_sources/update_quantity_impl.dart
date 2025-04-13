import 'package:dio/dio.dart';
import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/cart/data/data_sources/update_quantity_contract.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_response_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/utils/failures.dart';

@Injectable(as: UpdateQuantityContract)
class UpdateQuantityImpl implements UpdateQuantityContract {
  ApiManager apiManager;

  UpdateQuantityImpl({required this.apiManager});

  @override
  Future<ApiResult<List<CartItemsEntity>>> updateQuantity(
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
}
