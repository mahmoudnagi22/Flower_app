import 'package:flower_app/features/app_sections/home/categories/domain/entities/category_by_id_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/api_manager/api_result.dart';
import '../repositories/categories_repo.dart';

@injectable
class GetCategoriesByIdUseCase {
  CategoriesRepo repo;

  GetCategoriesByIdUseCase({required this.repo});

  Future<ApiResult<CategoriesByIdEntity>> call(String categoryId) {
    return repo.getCategoryById(categoryId);
  }
}
//