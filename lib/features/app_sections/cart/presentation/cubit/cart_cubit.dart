import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_response_entity.dart';
import 'package:flower_app/features/app_sections/cart/domain/use_cases/delete_cart_use_case.dart';
import 'package:flower_app/features/app_sections/cart/domain/use_cases/get_carts_entity.dart';
import 'package:flower_app/features/app_sections/cart/domain/use_cases/update_quantity_use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/models/api_result.dart';
import '../../../../../core/utils/status.dart';

part 'cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  UpdateQuantityUseCase updateUseCase;
  GetCartsUseCase getUseCase;
  DeleteCartUseCase deleteCartUseCase;

  CartCubit(
      {required this.updateUseCase, required this.getUseCase, required this.deleteCartUseCase})
      : super(const CartState());

  Future<void> updateQuantity(String cartId, int quantity) async {
    emit(state.copyWith(cartStatus: Status.loading));
    ApiResult<List<ProductEntity>> result = await updateUseCase.call(
        cartId, quantity);

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
        emit(state.copyWith(cartStatus: Status.success, cartsList: result.data),
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
        cartId);

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