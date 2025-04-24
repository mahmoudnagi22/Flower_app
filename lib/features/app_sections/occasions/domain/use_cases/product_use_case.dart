import 'package:injectable/injectable.dart';

import '../../../../../core/models/api_result.dart';
import '../../../categories/domain/entities/product_filter.dart';
import '../entities/products_entity.dart';
import '../repositories/occasion_repo.dart';

@injectable
class ProductsUseCase {
  final OccasionRepo repository;

  ProductsUseCase(this.repository);

  Future<ApiResult<List<ProductEntity>>> call(ProductFilter productFilter) {
    if(productFilter.occasionId !=null || productFilter.categoryId!=null || productFilter.filter!=null){
      return repository.getProducts(productFilter);
    }else{
      throw ArgumentError('Either occasionId or categoryId must be provided.');
    }
  }
}
