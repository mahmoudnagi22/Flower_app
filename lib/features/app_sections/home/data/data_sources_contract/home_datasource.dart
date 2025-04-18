import '../../../../../core/models/api_result.dart';
import '../model/HomeDataResponse.dart';

abstract class HomeDataSources{
  Future<ApiResult<HomeDataResponse>> getHomeData();
}