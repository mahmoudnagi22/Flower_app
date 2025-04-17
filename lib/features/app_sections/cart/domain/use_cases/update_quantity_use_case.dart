import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_response_entity.dart';
import 'package:flower_app/features/app_sections/cart/domain/repositories/cart_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateQuantityUseCase {
  CartsRepo repo;
  UpdateQuantityUseCase({required this.repo});

  Future<ApiResult<List<ProductEntity>>> call(String cartId, int quantity){
    return repo.updateQuantity(cartId,quantity);
  }
}