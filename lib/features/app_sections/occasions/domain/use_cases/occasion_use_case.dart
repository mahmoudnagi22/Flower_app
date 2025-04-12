import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:injectable/injectable.dart';

import '../entities/occasion_entity.dart';
import '../repositories/occasion_repo.dart';


@injectable
class OccasionUseCase {
  OccasionRepo occasionRepo;

  OccasionUseCase({required this.occasionRepo});

  Future<ApiResult<List<OccasionsEntity>>> call(){
    return occasionRepo.getOccasion();
  }
}
