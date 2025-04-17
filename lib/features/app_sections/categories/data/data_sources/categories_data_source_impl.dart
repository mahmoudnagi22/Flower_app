import 'package:dio/dio.dart';
import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/core/utils/failures.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/categories_entity.dart';
import 'categories_data_source_contract.dart';

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
}
