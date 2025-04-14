import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/home/best_seller/data/data_sources/contract/best_seller_data_socurce_contract.dart';
import 'package:flower_app/features/app_sections/home/best_seller/domain/entities/best_seller_product_entity.dart';
import 'package:flower_app/features/app_sections/home/best_seller/domain/repositories/get_best_seller_product_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GetBestSellerProductRepo)
class BestSellerRepoImpl implements GetBestSellerProductRepo {
  final BestSellerDataSourceContract bestSellerDataSourceContract;

  BestSellerRepoImpl(this.bestSellerDataSourceContract);

  @override
  Future<ApiResult<List<BestSellerProductEntity>>>
  getBestSellerProductList() async {
    return await bestSellerDataSourceContract.getBestSellers();
  }
}
