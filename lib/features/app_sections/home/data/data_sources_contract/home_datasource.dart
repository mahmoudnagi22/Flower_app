import '../../../../../core/api_manager/api_result.dart';
import '../model/HomeDataResponse.dart';

abstract class HomeDataSources{
  Future<ApiResult<HomeDataResponse>> getHomeData();
}