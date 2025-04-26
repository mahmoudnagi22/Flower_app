import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/app_sections/search/domain/entities/search_entity.dart';

abstract class SearchDataSource {
  Future<ApiResult<SearchEntity>> fetchProducts(String keyWord);
}