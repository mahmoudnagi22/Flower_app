import 'package:flower_app/core/models/api_result.dart';
import 'package:injectable/injectable.dart';
import '../entities/categories_entity.dart';
import '../repositories/categories_repo.dart';

@injectable
class GetCategoriesUseCase {
  CategoriesRepo repo;

  GetCategoriesUseCase({required this.repo});

  Future<ApiResult<List<CategoryEntity>>> call() {
    return repo.getCategories();
  }
}
