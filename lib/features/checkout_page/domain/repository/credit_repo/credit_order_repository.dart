import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/checkout_page/domain/entity/credit_order/request/credit_order_request_entity.dart';
import 'package:flower_app/features/checkout_page/domain/entity/credit_order/response/credit_order_response_entity.dart';

abstract class CreditOrderRepository {
  /// Method to place a credit order
  ///
  /// [request] contains the details of the order being placed.
  /// Returns an [ApiResult] containing the [CreditOrderResponseEntity].
  Future<ApiResult<CreditOrderResponseEntity>> placeCreditOrder(
      CreditOrderRequestEntity request,
      );
}
