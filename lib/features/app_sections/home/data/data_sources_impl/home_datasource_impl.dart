import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/features/app_sections/home/data/data_sources_contract/home_datasource.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/api_manager/api_result.dart';
import '../../../../../core/utils/failures.dart';
import '../model/HomeDataResponse.dart';
@Injectable(as: HomeDataSources )
class HomeDataSourceImpl implements HomeDataSources{
  ApiManager apiManager;
  HomeDataSourceImpl({required this.apiManager});
  
  @override
  Future<ApiResult<HomeDataResponse>> getHomeData()async {
    try{
      var response = await apiManager.homeTab();
      log("al data tamam");
      return response;
    }on DioException catch (e) {
      log("Dioo EX");
      return ApiErrorResult(
          failures: NetworkError(
              errorMessage: e.message ?? 'An unexpected error occurred'));

    }
  }
}