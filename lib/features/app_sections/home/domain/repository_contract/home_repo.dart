import '../../../../../core/models/api_result.dart';
import '../../data/model/HomeDataResponse.dart';

abstract class HomeRepo{
  Future<ApiResult<HomeDataResponse>> getHomeData();
}