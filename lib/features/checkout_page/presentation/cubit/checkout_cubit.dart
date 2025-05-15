import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/checkout_page/domain/entity/cash_order/request/order_entity_request.dart';
import 'package:flower_app/features/checkout_page/domain/entity/cash_order/request/shipping_address.dart';
import 'package:flower_app/features/checkout_page/domain/entity/cash_order/response/order_entity_response.dart';
import 'package:flower_app/features/checkout_page/domain/entity/credit_order/request/credit_order_request_entity.dart';
import 'package:flower_app/features/checkout_page/domain/entity/credit_order/response/credit_order_response_entity.dart';
import 'package:flower_app/features/checkout_page/domain/use_case/cash_usecase/cash_use_case.dart';
import 'package:flower_app/features/checkout_page/domain/use_case/credit_usecase/credit_use_case.dart';
import 'package:flower_app/features/checkout_page/presentation/cubit/checkout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit({
    required this.cashOrderUseCase,
    required this.creditOrderUseCase,
  }) : super(const CheckoutState(status: Status.initial));

  final CashOrderUseCase cashOrderUseCase;
  final CreditOrderUseCase creditOrderUseCase;
  String SelectedAddrees = "0";
  String selectedPayment="Cash on delivery";
  void selectAddress(String address) {
    SelectedAddrees = address;
  }

  // Place cash order
  void placeCashOrder(RequestShippingBody orderEntityRequest) async {
    emit(state.copyWith(status: Status.loading));

    final result = await cashOrderUseCase.execute(orderEntityRequest);
    if (result is ApiSuccessResult<CashOrderResponseEntity>) {
      emit(
        state.copyWith(
          status: Status.success,
          message: "Cash order placed successfully",
        ),
      );
    } else if (result is ApiErrorResult<CashOrderResponseEntity>) {
      emit(
        state.copyWith(
          status: Status.error,
          message: result.failures.errorMessage,
        ),
      );
    }
  }

  // Place credit order
  void placeCreditOrder(RequestShippingBody orderEntityRequest) async {
    emit(state.copyWith(status: Status.loading));

    final result = await creditOrderUseCase.execute(orderEntityRequest);

    if (result is ApiSuccessResult<CreditOrderResponseEntity>) {
      final Uri _url = Uri.parse(result.data.sessionUrl);
      print(result.data.sessionUrl);
      if(await canLaunchUrl(_url)){
        await launchUrl(_url);
      }
      emit(
        state.copyWith(status: Status.navigate, route: result.data.sessionUrl),
      );
    } else if (result is ApiErrorResult<CreditOrderResponseEntity>) {
      emit(
        state.copyWith(
          status: Status.error,
          message: result.failures.errorMessage,
        ),
      );
    }
  }
}
