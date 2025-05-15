import 'package:dio/dio.dart';
import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/core/utils/failures.dart';
import 'package:flower_app/features/app_sections/search/data/data_sources/search_data_source.dart';
import 'package:flower_app/features/app_sections/search/domain/entities/search_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/exceptions/exceptions_impl.dart';

@Injectable(as: SearchDataSource)
class SearchDataSourceImpl implements SearchDataSource {
  ApiManager apiManager;
  SearchDataSourceImpl({required this.apiManager});
  @override
  Future<ApiResult<SearchEntity>> fetchProducts(String keyWord) async{
    try {
      return await apiManager.fetchProducts(keyWord);
    } on DioException catch (errorMessage) {
      return  ApiErrorResult(
        failures:  Failures(errorMessage: errorMessage.message ?? ''),
      );
    }
  }

}