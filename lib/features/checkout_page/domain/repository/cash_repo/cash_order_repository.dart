import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/checkout_page/domain/entity/cash_order/request/order_entity_request.dart';
import 'package:flower_app/features/checkout_page/domain/entity/cash_order/response/order_entity_response.dart';

abstract class CashOrderRepository {
  /// Method to place a cash order
  ///
  /// [request] contains the details of the order being placed.
  /// Returns an [ApiResult] containing the [OrderEntityResponse].
  Future<ApiResult<CashOrderResponseEntity>> placeCashOrder(CashOrderRequestEntity request);
}
