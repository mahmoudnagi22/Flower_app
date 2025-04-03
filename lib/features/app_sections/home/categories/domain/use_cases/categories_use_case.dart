import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/home/categories/domain/entities/categories_entity.dart';
import 'package:flower_app/features/app_sections/home/categories/domain/repositories/categories_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoriesUseCase {
  CategoriesRepo repo;

  CategoriesUseCase({required this.repo});

  Future<ApiResult<List<CategoryEntity>>> call() {
    return repo.getCategories();
  }
}
