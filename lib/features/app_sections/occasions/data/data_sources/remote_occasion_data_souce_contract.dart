import 'package:flower_app/core/models/api_result.dart';
import '../../../categories/domain/entities/product_filter.dart';
import '../../domain/entities/occasion_entity.dart';
import '../../domain/entities/products_entity.dart';


abstract class RemoteOccasionDataSourceContract {
  Future<ApiResult<List<OccasionsEntity>>> getOccasion();
  Future<ApiResult<List<ProductEntity>>> getProducts(ProductFilter filter);

}