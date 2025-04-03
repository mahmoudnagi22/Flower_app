import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/home/categories/domain/entities/categories_entity.dart';

abstract class CategoryRepo {
  Future<ApiResult<List<CategoryEntity>>> getCategory();
}
