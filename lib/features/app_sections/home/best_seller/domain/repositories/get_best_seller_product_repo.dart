import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/home/best_seller/domain/entities/best_seller_product_entity.dart';

abstract class GetBestSellerProductRepo {
  Future<ApiResult<List<BestSellerProductEntity>>> getBestSellerProductList();
}
