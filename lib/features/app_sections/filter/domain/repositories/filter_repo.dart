import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/app_sections/filter/domain/entities/filter_entity.dart';

abstract class FilterRepo {
  Future<ApiResult<FilterEntity>> fetchProductsByFilter(String filter);
}