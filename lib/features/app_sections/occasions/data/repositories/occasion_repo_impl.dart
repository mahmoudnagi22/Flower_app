import 'package:flower_app/core/models/api_result.dart';
import 'package:injectable/injectable.dart';

import '../../../categories/domain/entities/product_filter.dart';
import '../../domain/entities/occasion_entity.dart';
import '../../domain/entities/products_entity.dart';
import '../../domain/repositories/occasion_repo.dart';
import '../data_sources/remote_occasion_data_souce_contract.dart';


@Injectable(as: OccasionRepo)
class OccasionRepoImpl implements OccasionRepo {
  RemoteOccasionDataSourceContract remoteOccasionDataSourceContract;
  OccasionRepoImpl({required this.remoteOccasionDataSourceContract});
  @override
  Future<ApiResult<List<OccasionsEntity>>> getOccasion() async{
    return await remoteOccasionDataSourceContract.getOccasion();
  }

  @override
  Future<ApiResult<List<ProductEntity>>> getProducts(ProductFilter productFilter) async {
    if (productFilter.occasionId != null || productFilter.categoryId != null || productFilter.filter!=null) {
      return await remoteOccasionDataSourceContract.getProducts(productFilter);
    } else {
      throw ArgumentError('Either occasionId or categoryId must be provided.');
    }
  }






}