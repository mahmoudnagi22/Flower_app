import 'dart:developer';

import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/app_sections/home/data/data_sources_contract/home_datasource.dart';
import 'package:flower_app/features/app_sections/home/data/model/HomeDataResponse.dart';
import 'package:flower_app/features/app_sections/home/domain/repository_contract/home_repo.dart';

class HomeRepoImpl implements HomeRepo{

  HomeDataSources homeDataSources;
  HomeRepoImpl({required this.homeDataSources});


  @override
  Future<ApiResult<HomeDataResponse>> getHomeData()async {

      var response = await homeDataSources.getHomeData();
      return response;

  }

}