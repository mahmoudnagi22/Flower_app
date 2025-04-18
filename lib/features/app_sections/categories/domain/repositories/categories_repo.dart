import 'package:flower_app/core/models/api_result.dart';
import '../entities/categories_entity.dart';

abstract class CategoriesRepo {
  Future<ApiResult<List<CategoryEntity>>> getCategories();
}
