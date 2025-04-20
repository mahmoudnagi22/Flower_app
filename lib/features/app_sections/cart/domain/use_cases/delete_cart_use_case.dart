
import 'package:injectable/injectable.dart';

import '../../../../../core/models/api_result.dart';
import '../entities/cart_response_entity.dart';
import '../repositories/cart_repo.dart';

@injectable
class DeleteCartUseCase {
  CartsRepo repo;
  DeleteCartUseCase({required this.repo});

  Future<ApiResult<List<ProductEntity>>> call(String cartId){
    return repo.deleteCart(cartId);
  }
}