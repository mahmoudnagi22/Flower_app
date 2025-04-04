import 'package:dio/dio.dart';
import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/core/utils/failures.dart';
import 'package:flower_app/features/app_sections/home/categories/data/data_sources/categories_data_source_contract.dart';
import 'package:flower_app/features/app_sections/home/categories/domain/entities/categories_entity.dart';
import 'package:flower_app/features/app_sections/home/categories/domain/entities/category_by_id_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoriesDataSourceContract)
class CategoriesDataSourceImpl implements CategoriesDataSourceContract {
  ApiManager apiManager;

  CategoriesDataSourceImpl({required this.apiManager});

  @override
  Future<ApiResult<List<CategoryEntity>>> getCategories() async {
    try {
      return apiManager.getCategories();
    } on DioException catch (errorMessage) {
      return ApiErrorResult(
        failures: NetworkError(errorMessage: errorMessage.message ?? ''),
      );
    }
  }

  @override
  Future<ApiResult<CategoriesByIdEntity>> getCategoryById(
    String categoryId,
  ) async {
    try {
      return apiManager.getCategoriesById(categoryId);
    } on DioException catch (errorMessage) {
      return ApiErrorResult(
        failures: NetworkError(errorMessage: errorMessage.message ?? ''),
      );
    }
  }
}
