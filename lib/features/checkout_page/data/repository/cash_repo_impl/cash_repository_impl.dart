import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/checkout_page/data/data_source/contract/cash_contract/cash_order_datasource_contract.dart';
import 'package:flower_app/features/checkout_page/data/dto/cash_dto/requests/order_dto_request.dart';
import 'package:flower_app/features/checkout_page/domain/entity/cash_order/request/order_entity_request.dart';
import 'package:flower_app/features/checkout_page/domain/entity/cash_order/request/shipping_address.dart';
import 'package:flower_app/features/checkout_page/domain/entity/cash_order/response/order_entity_response.dart';
import 'package:flower_app/features/checkout_page/domain/repository/cash_repo/cash_order_repository.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: CashOrderRepository)
class CashOrderRepoImpl implements CashOrderRepository {
  final CashCheckoutServiceContract cashCheckoutServiceContract;

  CashOrderRepoImpl({required this.cashCheckoutServiceContract});

  @override
  Future<ApiResult<CashOrderResponseEntity>> placeCashOrder(
    RequestShippingBody request,
  ) {
    // Assuming OrderRequest can be created from OrderEntityRequest
    // You might need to adjust the conversion logic based on your actual classes
    //CashOrderRequestDto orderRequest = CashOrderRequestDto.fromEntity(request);

    return cashCheckoutServiceContract.performCashCheckout(request);
  }
}
