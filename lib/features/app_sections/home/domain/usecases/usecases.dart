import 'package:flower_app/features/app_sections/home/domain/repository_contract/home_repo.dart';

import '../../../../../core/models/api_result.dart';
import '../../data/model/HomeDataResponse.dart';

class HomeTabUseCases{
  HomeRepo homeRepo;
  HomeTabUseCases({required this.homeRepo});
  Future<ApiResult<HomeDataResponse>> call(){
    return homeRepo.getHomeData();
  }
}