import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/update_quantity_response_entity.dart';

abstract class UpdateQuantityRepo {

  Future<ApiResult<UpdateQuantityResponseEntity>> updateQuantity(int quantity);
}