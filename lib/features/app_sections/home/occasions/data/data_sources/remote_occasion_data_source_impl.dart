import 'package:dio/dio.dart';
import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/core/utils/failures.dart';
import 'package:flower_app/features/app_sections/home/occasions/data/data_sources/remote_occasion_data_souce_contract.dart';
import 'package:flower_app/features/app_sections/home/occasions/domain/entities/occasion_by_id_entity.dart';
import 'package:flower_app/features/app_sections/home/occasions/domain/entities/occasion_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteOccasionDataSourceContract)
class RemoteOccasionDataSourceImpl implements RemoteOccasionDataSourceContract {
  ApiManager apiManager;

  RemoteOccasionDataSourceImpl({required this.apiManager});

  @override
  Future<ApiResult<List<OccasionsEntity>>> getOccasion() async {
    try {
      return await apiManager.getOccasions();
    } on DioException catch (e) {
      return ApiErrorResult(
        failures: NetworkError(
          errorMessage: e.message ?? 'An unexpected error occurred',
        ),
      );
    }
  }

  @override
  Future<ApiResult<OccasionsByIdEntity>> getOccasionById(
    String occasionId,
  ) async {
    try {
      return await apiManager.getOccasionById(occasionId);
    } on DioException catch (e) {
      return ApiErrorResult(
        failures: NetworkError(
          errorMessage: e.message ?? 'An unexpected error occurred',
        ),
      );
    }
  }
}
