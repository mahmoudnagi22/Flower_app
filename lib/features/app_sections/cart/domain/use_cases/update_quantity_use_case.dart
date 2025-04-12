import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/update_quantity_response_entity.dart';
import 'package:flower_app/features/app_sections/cart/domain/repositories/update_quantity_repo.dart';

class UpdateQuantityUseCase {
  UpdateQuantityRepo repo;
  UpdateQuantityUseCase({required this.repo});

  Future<ApiResult<UpdateQuantityResponseEntity>> call(int quantity){
    return repo.updateQuantity(quantity);
  }
}