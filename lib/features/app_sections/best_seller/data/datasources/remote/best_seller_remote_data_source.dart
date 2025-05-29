import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/app_sections/best_seller/data/datasources/contract/best_seller_contract_data_source.dart';
import 'package:flower_app/features/app_sections/best_seller/data/models/best_seller_dto.dart';
import 'package:flower_app/features/app_sections/best_seller/data/service/api_call.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: BestSellerContractDataSource)
class BestSellerRemoteDataSource implements BestSellerContractDataSource {
  BestSellerApiCall _apiCall;
  BestSellerRemoteDataSource(this._apiCall);

  @override
  Future<ApiResult<List<BestSellerDto>>> getBestSellerItems() {
   return _apiCall.getBestSeller();
  }
}