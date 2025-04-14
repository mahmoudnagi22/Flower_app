import 'package:dio/dio.dart';
import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/core/utils/failures.dart';
import 'package:flower_app/features/app_sections/home/best_seller/data/data_sources/contract/best_seller_data_socurce_contract.dart';
import 'package:flower_app/features/app_sections/home/best_seller/domain/entities/best_seller_product_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BestSellerDataSourceContract)
class BestSellerDataSourceRemote implements BestSellerDataSourceContract {
  final ApiManager apiManager;

  BestSellerDataSourceRemote(this.apiManager);

  @override
  Future<ApiResult<List<BestSellerProductEntity>>> getBestSellers() async {
    try {
      return await apiManager.getBestSellers();
    } on DioException catch (errorMessage) {
      return ApiErrorResult(
        failures: NetworkError(errorMessage: errorMessage.message ?? ''),
      );
    }
  }
}
