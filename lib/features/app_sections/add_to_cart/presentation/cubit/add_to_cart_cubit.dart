import 'package:dio/dio.dart';
import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/features/app_sections/add_to_cart/data/add_to_cart_data_source_impl/add_to_cart_data_source_impl.dart';
import 'package:flower_app/features/app_sections/add_to_cart/data/add_to_cart_repo_impl/add_to_cart_repo_impl.dart';
import 'package:flower_app/features/app_sections/add_to_cart/domain/add_to_cart_use_cases/add_to_cart_use_cases.dart';
import 'package:flower_app/features/app_sections/add_to_cart/presentation/cubit/add_to_cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/models/api_result.dart';
import '../../data/model/AddToCaetResponse.dart';
import '../../data/model/add_to_cart_parameters.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit() : super(AddToCartInitState());

  AddToCartUseCases addToCartUseCases = AddToCartUseCases(
    addToCartRepo: AddToCartRepoImpl(
      addToCartDataSource: AddToCartDataSourceImpl(
        apiManager: ApiManager(Dio()),
      ),
    ),
  );

  addToCart(AddToCartParameters parameters) async {
    emit(AddToCartLoadingState());
    final result = await addToCartUseCases.call(
      AddToCartParameters(product: parameters.product),
    );

    switch (result) {
      case ApiSuccessResult<AddToCartResponse>():
        emit(AddToCartSuccessState(addToCartResponse: result.data));
      case ApiErrorResult<AddToCartResponse>():
        emit(AddToCartErrorState(massage: result.failures.errorMessage));
    }
  }
}
