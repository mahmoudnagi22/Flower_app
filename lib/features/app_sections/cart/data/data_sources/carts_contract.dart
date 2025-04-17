import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_response_entity.dart';

abstract class CartsContract {
  Future<ApiResult<List<ProductEntity>>> updateQuantity(
    String cartId,
    int quantity,
  );
  Future<ApiResult<List<CartItemsEntity>>> getCarts();
  Future<ApiResult<List<ProductEntity>>> deleteCart(String cartId);
}
