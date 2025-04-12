import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/update_quantity_response_entity.dart';
import 'package:flower_app/features/app_sections/cart/domain/repositories/update_quantity_repo.dart';
import 'package:injectable/injectable.dart';

import '../data_sources/update_quantity_contract.dart';

@Injectable(as: UpdateQuantityRepo)
class UpdateCartRepoImpl implements UpdateQuantityRepo {
  UpdateQuantityContract dataSource;
  UpdateCartRepoImpl({required this.dataSource});
  @override
  Future<ApiResult<UpdateQuantityResponseEntity>> updateQuantity(String cartId,int quantity) {
    return dataSource.updateQuantity(cartId, quantity);
  }

}