import '../../../../../core/models/api_result.dart';
import '../../domain/entities/categories_entity.dart';

abstract class CategoriesDataSourceContract {
  Future<ApiResult<List<CategoryEntity>>> getCategories();
}