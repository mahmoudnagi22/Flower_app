import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/checkout_page/domain/entity/cash_order/request/order_entity_request.dart';
import 'package:flower_app/features/checkout_page/domain/entity/cash_order/request/shipping_address.dart';
import 'package:flower_app/features/checkout_page/domain/entity/cash_order/response/order_entity_response.dart';
import 'package:flower_app/features/checkout_page/domain/repository/cash_repo/cash_order_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class CashOrderUseCase {
  final CashOrderRepository orderRepository;

  CashOrderUseCase({
    required this.orderRepository,
  });

  /// Executes the cash order process by calling the repository
  ///
  /// [request] contains the details of the cash order to be placed.
  /// Returns the result of placing the cash order, containing an [OrderEntityResponse].
  Future<ApiResult<CashOrderResponseEntity>> execute(RequestShippingBody request) {
    return orderRepository.placeCashOrder(request);
  }
}
