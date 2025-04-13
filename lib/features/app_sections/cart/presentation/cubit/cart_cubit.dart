import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_response_entity.dart';
import 'package:flower_app/features/app_sections/cart/domain/use_cases/update_quantity_use_case.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/utils/status.dart';

part 'cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  UpdateQuantityUseCase useCase;

  CartCubit({required this.useCase})
    : super(const CartState());

  Future<void> updateQuantity(String cartId, int quantity) async {
    emit(state.copyWith(updateStatus: Status.loading));
    ApiResult<List<CartItemsEntity>> result = await useCase.call(
        cartId, quantity);

    switch (result) {
      case ApiSuccessResult<List<CartItemsEntity>>():
        emit(
          state.copyWith(updateStatus: Status.success, updateList: result.data),
        );
      case ApiErrorResult<List<CartItemsEntity>>():
        emit(
          state.copyWith(
            updateStatus: Status.error,
            updateError: result.failures.errorMessage,
          ),
        );
    }
  }
}
