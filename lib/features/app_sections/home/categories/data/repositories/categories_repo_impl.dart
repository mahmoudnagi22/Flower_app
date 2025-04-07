import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/home/categories/data/data_sources/categories_data_source_contract.dart';
import 'package:flower_app/features/app_sections/home/categories/domain/entities/categories_entity.dart';
import 'package:flower_app/features/app_sections/home/categories/domain/entities/category_by_id_entity.dart';
import 'package:flower_app/features/app_sections/home/categories/domain/repositories/categories_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoriesRepo)
class CategoriesRepoImpl implements CategoriesRepo {
  CategoriesDataSourceContract categoriesDataSourceContract;

  CategoriesRepoImpl({required this.categoriesDataSourceContract});

  @override
  Future<ApiResult<List<CategoryEntity>>> getCategories() async {
    return await categoriesDataSourceContract.getCategories();
  }

  // @override
  // Future<ApiResult<CategoriesByIdEntity>> getCategoryById(String categoryId) async{
  //   return await categoriesDataSourceContract.getCategoryById(categoryId);
  // }
}
