import 'package:equatable/equatable.dart';
import 'package:flower_app/features/app_sections/best_seller/domain/entities/best_seller_entity.dart';
import 'package:flower_app/features/app_sections/best_seller/domain/usecases/best_seller_use_case.dart';
import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/app_sections/occasions/domain/entities/products_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'best_seller_state.dart';
@injectable
class BestSellerCubit extends Cubit<BestSellerState> {
  final BestSellerUseCase useCase;

  BestSellerCubit(this.useCase) : super(const BestSellerState());

  Future<void> getBestSellerProducts() async {
    emit(state.copyWith(status: Status.loading));

    final result = await useCase();

    switch (result) {
      case ApiSuccessResult<List<ProductEntity>>():
        emit(
          state.copyWith(
            status: Status.loaded,
            products: result.data,
          ),
        );

      case ApiErrorResult<List<ProductEntity>>():
        emit(
          state.copyWith(
            status: Status.error,
            errorMessage: result.failures.errorMessage,
          ),
        );
    }
  }
}
