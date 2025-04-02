import 'package:injectable/injectable.dart';

import '../../../../../../core/api_manager/api_result.dart';
import '../entities/occasion_entity.dart';
import '../entities/occasion_by_id_entity.dart';
import '../repositories/occasion_repo.dart';

@injectable
class OccasionByIdUseCase {
  OccasionRepo occasionRepo;

  OccasionByIdUseCase({required this.occasionRepo});

  Future<ApiResult<List<OccasionByIdEntity>>> call(String occasionId){
    return occasionRepo.getOccasionById(occasionId);
  }
}
