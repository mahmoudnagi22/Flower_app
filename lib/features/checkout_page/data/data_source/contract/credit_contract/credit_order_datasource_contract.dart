import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/checkout_page/data/dto/credit_dto/request/credit_dto_request.dart';
import 'package:flower_app/features/checkout_page/data/dto/credit_dto/response/credit_dto_response.dart';
import 'package:flower_app/features/checkout_page/domain/entity/cash_order/request/shipping_address.dart';

abstract class CreditOrderDatasourceContract {
  Future<ApiResult<CreditOrderResponseDto>> performCreditCheckout(RequestShippingBody request);
}
