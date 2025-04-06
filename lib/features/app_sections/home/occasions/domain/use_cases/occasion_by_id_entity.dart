import 'package:injectable/injectable.dart';

import '../../../../../../core/api_manager/api_result.dart';
import '../entities/products_entity.dart';
import '../repositories/occasion_repo.dart';

@injectable
class ProductsUseCase {
  final OccasionRepo repository;

  ProductsUseCase(this.repository);

  Future<ApiResult<List<ProductEntity>>> call(String occasionId) {
    return repository.getProducts(occasionId);
  }
}
