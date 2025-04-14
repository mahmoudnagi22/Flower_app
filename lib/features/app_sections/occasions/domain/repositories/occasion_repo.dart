import 'package:flower_app/core/api_manager/api_result.dart';

import '../../../categories/domain/entities/product_filter.dart';
import '../entities/occasion_entity.dart';
import '../entities/products_entity.dart';

abstract class OccasionRepo {
  Future<ApiResult<List<OccasionsEntity>>> getOccasion();

  Future<ApiResult<List<ProductEntity>>> getProducts(ProductFilter filter);
}
