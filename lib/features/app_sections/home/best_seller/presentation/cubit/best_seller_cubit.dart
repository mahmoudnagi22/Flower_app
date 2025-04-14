import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/home/best_seller/domain/entities/best_seller_product_entity.dart';
import 'package:flower_app/features/app_sections/home/best_seller/domain/use_case/get_best_seller_use_case.dart';
import 'package:injectable/injectable.dart';

part 'best_seller_state.dart';

@injectable
class BestSellerCubit extends Cubit<BestSellerState> {
  final GetBestSellerUseCase getBestSellerUseCase;

  BestSellerCubit(this.getBestSellerUseCase)
    : super(BestSellerState(status: Status.loading));

  Future<void> getBestSellerProduct() async {
    emit(state.copyWith(status: Status.loading));

    final result = await getBestSellerUseCase();

    if (result is ApiSuccessResult<List<BestSellerProductEntity>>) {
      emit(state.copyWith(bestSellers: result.data, status: Status.success));
    } else if (result is ApiErrorResult<List<BestSellerProductEntity>>) {
      emit(
        state.copyWith(
          status: Status.failure,
          errorMessage: result.failures.toString(),
        ),
      );
    }
  }
}
