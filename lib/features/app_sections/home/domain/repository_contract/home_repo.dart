import '../../../../../core/api_manager/api_result.dart';
import '../../data/model/HomeDataResponse.dart';

abstract class HomeRepo{
  Future<ApiResult<HomeDataResponse>> getHomeData();
}