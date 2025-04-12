import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/categories_entity.dart';
import '../../domain/repositories/categories_repo.dart';
import '../data_sources/categories_data_source_contract.dart';

@Injectable(as: CategoriesRepo)
class CategoriesRepoImpl implements CategoriesRepo {
  CategoriesDataSourceContract categoriesDataSourceContract;

  CategoriesRepoImpl({required this.categoriesDataSourceContract});

  @override
  Future<ApiResult<List<CategoryEntity>>> getCategories() async {
    return await categoriesDataSourceContract.getCategories();
  }
}
