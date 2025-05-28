import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/app_sections/best_seller/data/models/best_seller_dto.dart';

abstract class BestSellerContractDataSource {
  Future<ApiResult<List<BestSellerDto>>> getBestSellerItems();

}