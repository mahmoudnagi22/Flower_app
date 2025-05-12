import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/features/checkout_page/data/data_source/contract/credit_contract/credit_order_datasource_contract.dart';
import 'package:flower_app/features/checkout_page/data/dto/credit_dto/request/credit_dto_request.dart';
import 'package:flower_app/features/checkout_page/domain/entity/credit_order/request/credit_order_request_entity.dart';
import 'package:flower_app/features/checkout_page/domain/entity/credit_order/response/credit_order_response_entity.dart';
import 'package:flower_app/features/checkout_page/domain/repository/credit_repo/credit_order_repository.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:CreditOrderRepository )
class CreditOrderRepoImpl implements CreditOrderRepository {
  final CreditOrderDatasourceContract creditCheckoutServiceContract;

  CreditOrderRepoImpl({required this.creditCheckoutServiceContract});

  @override
  Future<ApiResult<CreditOrderResponseEntity>> placeCreditOrder(CreditOrderRequestEntity request) async{
    CreditOrderRequestDto orderRequest = CreditOrderRequestDto.fromEntity(request);
    return await creditCheckoutServiceContract.performCreditCheckout(orderRequest);
  }



}
