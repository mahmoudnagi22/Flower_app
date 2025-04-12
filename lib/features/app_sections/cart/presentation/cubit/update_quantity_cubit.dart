import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/update_quantity_response_entity.dart';
import 'package:flower_app/features/app_sections/cart/domain/use_cases/update_quantity_use_case.dart';

import '../../../../../core/utils/status.dart';

part 'update_quantity_state.dart';

class UpdateQuantityCubit extends Cubit<UpdateQuantityState> {
  UpdateQuantityUseCase useCase;

  UpdateQuantityCubit({required this.useCase})
    : super(const UpdateQuantityState());

  Future<void> updateQuantity(String cartId, int quantity) async {
    emit(state.copyWith(updateStatus: Status.loading));
    ApiResult<UpdateQuantityResponseEntity> result = await useCase.call(
      cartId,
      quantity,
    );

    switch (result) {
      case ApiSuccessResult<UpdateQuantityResponseEntity>():
        emit(
          state.copyWith(updateStatus: Status.success, updateList: result.data),
        );
      case ApiErrorResult<UpdateQuantityResponseEntity>():
        emit(
          state.copyWith(
            updateStatus: Status.error,
            updateError: result.failures.errorMessage,
          ),
        );
    }
  }
}
