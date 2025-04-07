import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/home/occasions/domain/entities/occasion_entity.dart';
import 'package:flower_app/features/app_sections/home/occasions/domain/entities/products_entity.dart';

import '../../../categories/domain/entities/product_filter.dart';


abstract class RemoteOccasionDataSourceContract {
  Future<ApiResult<List<OccasionsEntity>>> getOccasion();
  Future<ApiResult<List<ProductEntity>>> getProducts(ProductFilter filter);

}