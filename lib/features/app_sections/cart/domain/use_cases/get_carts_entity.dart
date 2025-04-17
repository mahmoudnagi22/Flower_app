import 'package:injectable/injectable.dart';

import '../../../../../core/api_manager/api_result.dart';
import '../entities/cart_response_entity.dart';
import '../repositories/cart_repo.dart';

@injectable
class GetCartsUseCase {
  CartsRepo repo;
  GetCartsUseCase({required this.repo});

  Future<ApiResult<List<CartItemsEntity>>> call()async{
    return await repo.getCarts();
  }
}