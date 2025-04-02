import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/home/occasions/domain/entities/occasion_entity.dart';

import '../../domain/entities/occasion_by_id_entity.dart';

abstract class RemoteOccasionDataSourceContract {
  Future<ApiResult<List<OccasionsEntity>>> getOccasion();
  Future<ApiResult<List<OccasionByIdEntity>>> getOccasionById(String occasionId);

}