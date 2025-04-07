import 'package:flower_app/features/app_sections/home/categories/domain/entities/categories_entity.dart';
import 'package:flower_app/features/app_sections/home/categories/domain/entities/category_by_id_entity.dart';

import '../../../../../../core/api_manager/api_result.dart';

abstract class CategoriesDataSourceContract {
  Future<ApiResult<List<CategoryEntity>>> getCategories();
  // Future<ApiResult<CategoriesByIdEntity>> getCategoryById(String categoryId);
}