import '../../../../../core/models/api_result.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_response_entity.dart';
import 'package:flower_app/features/app_sections/cart/domain/repositories/cart_repo.dart';
import 'package:injectable/injectable.dart';

import '../data_sources/carts_contract.dart';

@Injectable(as: CartsRepo)
class CartRepoImpl implements CartsRepo {
  CartsContract dataSource;
  CartRepoImpl({required this.dataSource});
  @override
  Future<ApiResult<List<ProductEntity>>> updateQuantity(String cartId,int quantity) {
    return dataSource.updateQuantity(cartId, quantity);
  }

  @override
  Future<ApiResult<List<CartItemsEntity>>> getCarts() async{
    return await dataSource.getCarts();
  }

  @override
  Future<ApiResult<List<ProductEntity>>> deleteCart(String cartId) async{
    return await dataSource.deleteCart(cartId);
  }

}