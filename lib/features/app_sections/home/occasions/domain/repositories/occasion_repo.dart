import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/home/occasions/domain/entities/occasion_entity.dart';

import '../entities/occasion_id_entity.dart';

abstract class OccasionRepo {
  Future<ApiResult<List<OccasionsEntity>>> getOccasion();
  Future<ApiResult<OccasionByIdEntity>> getOccasionById(String occasionId);
}