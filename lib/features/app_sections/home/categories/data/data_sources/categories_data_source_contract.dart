import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/categories/domain/entities/categories_entity.dart';
import 'package:flower_app/features/app_sections/categories/domain/entities/category_by_id_entity.dart';

abstract class CategoriesDataSourceContract {
  Future<ApiResult<List<CategoryEntity>>> getCategories();
  Future<ApiResult<CategoriesByIdEntity>> getCategoryById(String categoryId);
}
