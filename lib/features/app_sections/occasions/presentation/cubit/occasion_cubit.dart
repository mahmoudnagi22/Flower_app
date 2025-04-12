import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/core/utils/status.dart';
import 'package:injectable/injectable.dart';

import '../../../categories/domain/entities/product_filter.dart';
import '../../domain/entities/occasion_entity.dart';
import '../../domain/entities/products_entity.dart';
import '../../domain/use_cases/occasion_use_case.dart';
import '../../domain/use_cases/product_use_case.dart';

part 'occasion_state.dart';

@injectable
class OccasionCubit extends Cubit<OccasionState> {
  OccasionCubit({required this.occasionUseCase, required this.productsUseCase})
    : super(const OccasionState());

  OccasionUseCase occasionUseCase;
  ProductsUseCase productsUseCase;

  void getOccasions() async {
    emit(state.copyWith(occasionState: Status.loading));
    ApiResult<List<OccasionsEntity>> result = await occasionUseCase.call();

    switch (result) {
      case ApiSuccessResult<List<OccasionsEntity>>():
        emit(
          state.copyWith(
            occasionList: result.data,
            occasionState: Status.success,
          ),
        );
        if (result.data.isNotEmpty) {
          getProducts(ProductFilter(occasionId: result.data.first.id));
        }
        break;

      case ApiErrorResult<List<OccasionsEntity>>():
        emit(
          state.copyWith(
            occasionError: result.failures.errorMessage,
            occasionState: Status.error,
          ),
        );
    }
  }


  void getProducts(ProductFilter filter) async {
    emit(state.copyWith(productsState: Status.loading));

    ApiResult<List<ProductEntity>> result = await productsUseCase.call(filter);

    switch (result) {
      case ApiSuccessResult<List<ProductEntity>>():
        emit(
          state.copyWith(productsState: Status.success, products: result.data),
        );
      case ApiErrorResult<List<ProductEntity>>():
        emit(
          state.copyWith(
            productsState: Status.error,
            occasionError: result.failures.errorMessage,
          ),
        );
    }
  }
}
