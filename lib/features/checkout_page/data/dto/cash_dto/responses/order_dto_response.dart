import 'package:flower_app/features/checkout_page/data/dto/cash_dto/responses/product_dto_response.dart';
import 'package:flower_app/features/checkout_page/domain/entity/cash_order/response/order_entity_response.dart';

class CashOrderResponseDto extends CashOrderResponseEntity {
  CashOrderResponseDto({

    required String id,
    required String user,
    required List<OrderEntityItemResponse> orderItems,
    required double totalPrice,
    required String paymentType,
    required bool isPaid,
    required bool isDelivered,
    required String state,
    required String orderNumber,
    required String createdAt,
    required String updatedAt,
  }) : super(
    id: id,
    user: user,
    orderItems: orderItems,
    totalPrice: totalPrice,
    paymentType: paymentType,
    isPaid: isPaid,
    isDelivered: isDelivered,
    state: state,
    orderNumber: orderNumber,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  // تحويل JSON إلى OrderResponse
  factory CashOrderResponseDto.fromJson(Map<String, dynamic> json) {
    return CashOrderResponseDto(
      id:'' ,//json['id'],
      user:'' ,//json['user'],
      orderItems:[],// (json['orderItems'] as List)
          //.map((item) => OrderItemResponse.fromJson(item))
          //.toList(),
      totalPrice:0,// json['totalPrice'],
      paymentType:'',// json['paymentType'],
      isPaid: false,//json['isPaid'],
      isDelivered:false,// json['isDelivered'],
      state: '',//json['state'],
      orderNumber:'',// json['orderNumber'],
      createdAt: '',//json['createdAt'],
      updatedAt: '',//json['updatedAt'],
    );
  }
}

class OrderItemResponse extends OrderEntityItemResponse {
  OrderItemResponse({
    required String id,
    required ProductResponseDto product,
    required double price,
    required int quantity,
  }) : super(
    id: id,
    product: product,
    price: price,
    quantity: quantity,
  );

  // تحويل JSON إلى OrderItemResponse
  factory OrderItemResponse.fromJson(Map<String, dynamic> json) {
    return OrderItemResponse(
      id: json['id'],
      product: ProductResponseDto.fromJson(json['product']),
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}
