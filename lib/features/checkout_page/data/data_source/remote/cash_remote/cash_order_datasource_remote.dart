import 'package:dio/dio.dart';
import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/checkout_page/data/data_source/contract/cash_contract/cash_order_datasource_contract.dart';
import 'package:flower_app/features/checkout_page/data/dto/cash_dto/requests/order_dto_request.dart';
import 'package:flower_app/features/checkout_page/data/dto/cash_dto/responses/order_dto_response.dart';
import 'package:flower_app/features/checkout_page/data/service/cash_api_call/cash_order_service.dart';
import 'package:flower_app/features/checkout_page/domain/entity/cash_order/request/shipping_address.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/utils/failures.dart';
@Injectable(as: CashCheckoutServiceContract)
class CashCheckoutServiceRemote implements CashCheckoutServiceContract{
  CashOrderService checkoutPageService;
  CashCheckoutServiceRemote({required this.checkoutPageService});
  @override
  Future<ApiResult<CashOrderResponseDto>> performCashCheckout(RequestShippingBody request) async{
    try {
      var response = await checkoutPageService.CashCheckOutMethod(request);
      return response;
    } on DioException catch (e) {
      return ApiErrorResult(
        failures: NetworkError(
            errorMessage: e.message ?? 'An unexpected error occurred',
        ),
      );

    }
  }

}