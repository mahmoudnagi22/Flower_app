import '../../../../../../core/api_manager/api_result.dart';
import '../../domain/entities/categories_entity.dart';

abstract class CategoriesDataSourceContract {
  Future<ApiResult<List<CategoryEntity>>> getCategories();
}