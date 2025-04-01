import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/home/occasions/domain/entities/occasion_entity.dart';
import 'package:flower_app/features/app_sections/home/occasions/domain/repositories/occasion_repo.dart';
import 'package:injectable/injectable.dart';


@injectable
class OccasionUseCase {
  OccasionRepo occasionRepo;

  OccasionUseCase({required this.occasionRepo});

  Future<ApiResult<List<OccasionsEntity>>> call(){
    return occasionRepo.getOccasion();
  }
}
