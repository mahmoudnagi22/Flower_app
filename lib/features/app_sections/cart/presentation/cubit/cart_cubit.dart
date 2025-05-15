import 'package:equatable/equatable.dart';
import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/core/utils/status.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_response_entity.dart';
import 'package:flower_app/features/app_sections/cart/domain/use_cases/delete_cart_use_case.dart';
import 'package:flower_app/features/app_sections/cart/domain/use_cases/get_carts_entity.dart';
import 'package:flower_app/features/app_sections/cart/domain/use_cases/update_quantity_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  UpdateQuantityUseCase updateUseCase;
  GetCartsUseCase getUseCase;
  DeleteCartUseCase deleteCartUseCase;

  CartCubit({
    required this.updateUseCase,
    required this.getUseCase,
    required this.deleteCartUseCase,
  }) : super(const CartState());
  double get totalPrice {
    if (state.cartsList == null) return 0.0;

    return state.cartsList
            ?.map((e) => (e.price ?? 0.0) * (e.quantity ?? 0))
            .fold<double>(0.0, (a, b) => a + b) ??
        0.0;
  }

  Future<void> updateQuantity(String cartId, int quantity) async {
    emit(state.copyWith(cartStatus: Status.loading));
    ApiResult<List<ProductEntity>> result = await updateUseCase.call(
      cartId,
      quantity,
    );

    switch (result) {
      case ApiSuccessResult<List<ProductEntity>>():
        emit(
          state.copyWith(cartStatus: Status.success, updateList: result.data),
        );
      case ApiErrorResult<List<ProductEntity>>():
        emit(
          state.copyWith(
            cartStatus: Status.error,
            updateError: result.failures.errorMessage,
          ),
        );
    }
  }

  Future<void> getCarts() async {
    emit(state.copyWith(cartStatus: Status.loading));
    ApiResult<List<CartItemsEntity>> result = await getUseCase.call();

    switch (result) {
      case ApiSuccessResult<List<CartItemsEntity>>():
        emit(
          state.copyWith(cartStatus: Status.success, cartsList: result.data),
        );
      case ApiErrorResult<List<CartItemsEntity>>():
        emit(
          state.copyWith(
            cartStatus: Status.error,
            updateError: result.failures.errorMessage,
          ),
        );
    }
  }

  Future<void> deleteItem(String cartId) async {
    emit(state.copyWith(cartStatus: Status.loading));

    ApiResult<List<ProductEntity>> result = await deleteCartUseCase.call(
      cartId,
    );

    switch (result) {
      case ApiSuccessResult<List<ProductEntity>>():
        emit(
          state.copyWith(cartStatus: Status.success, deleteItem: result.data),
        );
        getCarts();
      case ApiErrorResult<List<ProductEntity>>():
        emit(
          state.copyWith(
            cartStatus: Status.error,
            updateError: result.failures.errorMessage,
          ),
        );
    }
  }
}
