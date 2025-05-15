import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/checkout_page/domain/entity/cash_order/request/order_entity_request.dart';
import 'package:flower_app/features/checkout_page/domain/entity/cash_order/response/order_entity_response.dart';
import 'package:flower_app/features/checkout_page/domain/entity/credit_order/request/credit_order_request_entity.dart';
import 'package:flower_app/features/checkout_page/domain/entity/credit_order/response/credit_order_response_entity.dart';
import 'package:flower_app/features/checkout_page/domain/use_case/cash_usecase/cash_use_case.dart';
import 'package:flower_app/features/checkout_page/domain/use_case/credit_usecase/credit_use_case.dart';
import 'package:flower_app/features/checkout_page/presentation/cubit/checkout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit({
    required this.cashOrderUseCase,
    required this.creditOrderUseCase,
  }) : super(const CheckoutState(status: Status.initial));

  final CashOrderUseCase cashOrderUseCase;
  final CreditOrderUseCase creditOrderUseCase;

  // Place cash order
  void placeCashOrder(CashOrderRequestEntity orderEntityRequest) async {
    emit(state.copyWith(status: Status.loading));

    final result = await cashOrderUseCase.execute(orderEntityRequest);

    if (result is ApiSuccessResult<CashOrderResponseEntity>) {
      emit(state.copyWith(
        status: Status.success,
        message: "Cash order placed successfully",
      ));
    } else if (result is ApiErrorResult<CashOrderResponseEntity>) {
      emit(state.copyWith(
        status: Status.error,
        message: result.failures.errorMessage,
      ));
    }
  }

  // Place credit order
  void placeCreditOrder(CreditOrderRequestEntity orderEntityRequest) async {
    emit(state.copyWith(status: Status.loading));

    final result = await creditOrderUseCase.execute(orderEntityRequest);

    if (result is ApiSuccessResult<CreditOrderResponseEntity>) {
      emit(state.copyWith(
        status: Status.success,
        message: "Credit order placed successfully",
      ));
    } else if (result is ApiErrorResult<CreditOrderResponseEntity>) {
      emit(state.copyWith(
        status: Status.error,
        message: result.failures.errorMessage,
      ));
    }
  }
}
