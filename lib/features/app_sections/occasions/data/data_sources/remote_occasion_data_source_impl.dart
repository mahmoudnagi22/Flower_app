import 'package:dio/dio.dart';
import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/core/utils/failures.dart';
import 'package:flower_app/features/app_sections/occasions/data/data_sources/remote_occasion_data_souce_contract.dart';
import 'package:injectable/injectable.dart';

import '../../../categories/domain/entities/product_filter.dart';
import '../../domain/entities/occasion_entity.dart';
import '../../domain/entities/products_entity.dart';

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
  Future<ApiResult<List<ProductEntity>>> getProducts(ProductFilter filter) async{
    try {
      if (filter.occasionId != null || filter.categoryId != null) {
        return await apiManager.getProducts(filter);
      }else{
        throw ArgumentError('Either occasionId or categoryId must be provided.');
      }
    } on DioException catch (e) {
      return ApiErrorResult(
        failures: NetworkError(
          errorMessage: e.message ?? 'An unexpected error occurred',
        ),
      );
    }
  }
}
