import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/checkout_page/domain/entity/credit_order/request/credit_order_request_entity.dart';
import 'package:flower_app/features/checkout_page/domain/entity/credit_order/response/credit_order_response_entity.dart';
import 'package:flower_app/features/checkout_page/domain/repository/credit_repo/credit_order_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class CreditOrderUseCase {
  final CreditOrderRepository orderRepository;

  CreditOrderUseCase({
    required this.orderRepository,
  });

  /// Executes the credit order process by calling the repository
  ///
  /// [request] contains the details of the credit order to be placed.
  /// Returns the result of placing the credit order, containing a [CreditOrderResponseEntity].
  Future<ApiResult<CreditOrderResponseEntity>> execute(
      CreditOrderRequestEntity request,
      ) {
    return orderRepository.placeCreditOrder(request);
  }
}
