import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/home/occasions/domain/entities/occasion_entity.dart';

import '../entities/products_entity.dart';

abstract class OccasionRepo {
  Future<ApiResult<List<OccasionsEntity>>> getOccasion();

  Future<ApiResult<List<ProductEntity>>> getProducts(String occasionId);
}
