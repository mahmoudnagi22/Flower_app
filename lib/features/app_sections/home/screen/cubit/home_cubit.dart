import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/home/data/data_sources_impl/home_datasource_impl.dart';
import 'package:flower_app/features/app_sections/home/data/model/HomeDataResponse.dart';
import 'package:flower_app/features/app_sections/home/data/repositror_impl/home_repo_impl.dart';
import 'package:flower_app/features/app_sections/home/domain/usecases/usecases.dart';
import 'package:flower_app/features/app_sections/home/screen/cubit/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/failures.dart';
import '../../data/model/Products.dart';

class HomeTabCubit extends Cubit<HomeStates> {
  HomeTabCubit() : super(HomeLoadingStates());
  HomeTabUseCases homeTabUseCases = HomeTabUseCases(
    homeRepo: HomeRepoImpl(
      homeDataSources: HomeDataSourceImpl(apiManager: ApiManager(Dio())),
    ),
  );

  Future<ApiResult<HomeDataResponse>> getHomeData() async {
    emit(HomeLoadingStates());
    log("Load");
    var response = await homeTabUseCases.call();
    switch (response) {
      case ApiSuccessResult<HomeDataResponse>():
        emit(
          HomeSuccessStates(
            categories: response.data.categories,
            occasions: response.data.occasions,
            products: response.data.products,
            bestSeller: response.data.bestSeller,
          ),
        );
        log("Success Home Cubit");
      //  log("${response.data.categories}");
      case ApiErrorResult<HomeDataResponse>():
        log("EEEEEEERror");
        emit(HomeErrorStates(massage: response.failures.errorMessage));
    }
    return ApiErrorResult(failures: Failures(errorMessage: "Unknown error"));
  }
}
