import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_response_entity.dart';

abstract class UpdateQuantityContract {
  Future<ApiResult<List<CartItemsEntity>>> updateQuantity(
    String cartId,
    int quantity,
  );
}
