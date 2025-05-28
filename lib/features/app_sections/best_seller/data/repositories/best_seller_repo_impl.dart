import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/app_sections/best_seller/data/datasources/contract/best_seller_contract_data_source.dart';
import 'package:flower_app/features/app_sections/best_seller/domain/repositories/bestseller_repositories.dart';
import 'package:flower_app/features/app_sections/occasions/domain/entities/products_entity.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: BestSellerRepository)
class BestSellerRepoImpl implements BestSellerRepository {
  final BestSellerContractDataSource contractDataSource;

  BestSellerRepoImpl({required this.contractDataSource});

  @override
  Future<ApiResult<List<ProductEntity>>> getBestSellerProducts() {
    return contractDataSource.getBestSellerItems();
  }


}