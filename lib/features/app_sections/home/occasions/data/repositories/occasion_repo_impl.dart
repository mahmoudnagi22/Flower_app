import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/home/occasions/data/data_sources/remote_occasion_data_souce_contract.dart';
import 'package:flower_app/features/app_sections/home/occasions/domain/entities/occasion_entity.dart';
import 'package:flower_app/features/app_sections/home/occasions/domain/entities/occasion_by_id_entity.dart';
import 'package:flower_app/features/app_sections/home/occasions/domain/repositories/occasion_repo.dart';
import 'package:injectable/injectable.dart';

import '../models/occasions_by_id_dto.dart';

@Injectable(as: OccasionRepo)
class OccasionRepoImpl implements OccasionRepo {
  RemoteOccasionDataSourceContract remoteOccasionDataSourceContract;
  OccasionRepoImpl({required this.remoteOccasionDataSourceContract});
  @override
  Future<ApiResult<List<OccasionsEntity>>> getOccasion() async{
    return await remoteOccasionDataSourceContract.getOccasion();
  }

  @override
  Future<ApiResult<OccasionsByIdEntity>> getOccasionById(String occasionId) async {
    return await remoteOccasionDataSourceContract.getOccasionById(occasionId);
  }

}