import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/app_sections/best_seller/data/models/best_seller_dto.dart';
import 'package:flower_app/features/app_sections/best_seller/domain/entities/best_seller_entity.dart';
import 'package:flower_app/features/app_sections/best_seller/domain/repositories/bestseller_repositories.dart';
import 'package:flower_app/features/app_sections/occasions/domain/entities/products_entity.dart';
import 'package:injectable/injectable.dart';
@injectable
class BestSellerUseCase {
  BestSellerRepository repository;
  BestSellerUseCase(this.repository);
  Future<ApiResult<List<ProductEntity>>> call() async {
    return await repository.getBestSellerProducts();
  }
}
