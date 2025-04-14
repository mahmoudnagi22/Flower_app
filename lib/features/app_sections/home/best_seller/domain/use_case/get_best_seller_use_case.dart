import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/home/best_seller/domain/entities/best_seller_product_entity.dart';
import 'package:flower_app/features/app_sections/home/best_seller/domain/repositories/get_best_seller_product_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetBestSellerUseCase {
  final GetBestSellerProductRepo getBestSellerProductRepo;
  GetBestSellerUseCase(this.getBestSellerProductRepo);
  Future<ApiResult<List<BestSellerProductEntity>>> call() async {
    return getBestSellerProductRepo.getBestSellerProductList();
  }
}
