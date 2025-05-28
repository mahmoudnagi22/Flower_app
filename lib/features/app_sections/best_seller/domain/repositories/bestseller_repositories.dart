import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/app_sections/best_seller/data/models/best_seller_dto.dart';
import 'package:flower_app/features/app_sections/best_seller/domain/entities/best_seller_entity.dart';
import 'package:flower_app/features/app_sections/occasions/domain/entities/products_entity.dart';

abstract class BestSellerRepository {
  Future<ApiResult<List<ProductEntity>>> getBestSellerProducts();
}
