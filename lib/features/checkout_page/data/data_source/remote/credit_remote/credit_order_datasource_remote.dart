import 'package:dio/dio.dart';
import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/checkout_page/data/data_source/contract/credit_contract/credit_order_datasource_contract.dart';
import 'package:flower_app/features/checkout_page/data/dto/credit_dto/request/credit_dto_request.dart';
import 'package:flower_app/features/checkout_page/data/dto/credit_dto/response/credit_dto_response.dart';
import 'package:flower_app/features/checkout_page/data/service/credit_api_call/credit_order_service.dart';
import 'package:flower_app/features/checkout_page/domain/entity/cash_order/request/shipping_address.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/utils/failures.dart';
@Injectable(as: CreditOrderDatasourceContract)
class CreditCheckoutServiceRemote implements CreditOrderDatasourceContract{
  CreditOrderService checkoutService;
  CreditCheckoutServiceRemote({required this.checkoutService});

  @override
  Future<ApiResult<CreditOrderResponseDto>> performCreditCheckout(RequestShippingBody request) async{
    try {
      var response = await checkoutService.CreditCheckOutMethod(request);
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