import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/home/categories/domain/entities/categories_entity.dart';
import 'package:flower_app/features/app_sections/home/categories/domain/repositories/category_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoryUseCase {
  CategoryRepo repo;

  CategoryUseCase({required this.repo});

  Future<ApiResult<List<CategoryEntity>>> call() {
    return repo.getCategory();
  }
}
