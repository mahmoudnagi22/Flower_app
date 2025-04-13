import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_response_entity.dart';
import 'package:flower_app/features/app_sections/cart/domain/repositories/update_quantity_repo.dart';
import 'package:injectable/injectable.dart';

import '../data_sources/update_quantity_contract.dart';

@Injectable(as: CartsRepo)
class CartRepoImpl implements CartsRepo {
  UpdateQuantityContract dataSource;
  CartRepoImpl({required this.dataSource});
  @override
  Future<ApiResult<List<CartItemsEntity>>> updateQuantity(String cartId,int quantity) {
    return dataSource.updateQuantity(cartId, quantity);
  }

  @override
  Future<ApiResult<List<CartItemsEntity>>> getCarts() {
    // TODO: implement getCarts
    throw UnimplementedError();
  }

}