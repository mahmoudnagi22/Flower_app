import 'package:flower_app/features/checkout_page/data/dto/cash_dto/requests/product_dto_request.dart';
import 'package:flower_app/features/checkout_page/domain/entity/cash_order/request/order_entity_request.dart';

class CashOrderRequestDto extends CashOrderRequestEntity {
  CashOrderRequestDto({
    required String user,
    required List<OrderItemRequest> orderItems,
    required double totalPrice,
    required String paymentType,
    required bool isPaid,
    required bool isDelivered,
    required String state,
    required String orderNumber,
    required String createdAt,
    required String updatedAt,
  }) : super(
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

  // تحويل JSON إلى OrderRequest
  factory CashOrderRequestDto.fromJson(Map<String, dynamic> json) {
    return CashOrderRequestDto(
      user: json['user'],
      orderItems:
          (json['orderItems'] as List)
              .map((item) => OrderItemRequest.fromJson(item))
              .toList(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      paymentType: json['paymentType'],
      isPaid: json['isPaid'],
      isDelivered: json['isDelivered'],
      state: json['state'],
      orderNumber: json['orderNumber'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  // تحويل OrderRequest إلى JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'orderItems':
          orderItems
              .map((item) => (item as OrderItemRequest).toJson())
              .toList(),
      'totalPrice': totalPrice,
      'paymentType': paymentType,
      'isPaid': isPaid,
      'isDelivered': isDelivered,
      'state': state,
      'orderNumber': orderNumber,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  static CashOrderRequestDto fromEntity(CashOrderRequestEntity entity) {
    return CashOrderRequestDto(
      user: entity.user,
      orderItems:
          entity.orderItems
              .map((item) => OrderItemRequest.fromEntity(item))
              .toList(),
      totalPrice: entity.totalPrice,
      paymentType: entity.paymentType,
      isPaid: entity.isPaid,
      isDelivered: entity.isDelivered,
      state: entity.state,
      orderNumber: entity.orderNumber,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}

class OrderItemRequest extends OrderEntityItemRequest {
  final ProductRequestDto product;

  OrderItemRequest({
    required this.product,
    required double price,
    required int quantity,
  }) : super(productId: product.title ?? "", price: price, quantity: quantity);

  // تحويل JSON إلى OrderItemRequest
  factory OrderItemRequest.fromJson(Map<String, dynamic> json) {
    return OrderItemRequest(
      product: ProductRequestDto.fromJson(json['product']),
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'],
    );
  }

  // تحويل OrderItemRequest إلى JSON
  @override
  Map<String, dynamic> toJson() {
    return {'product': product.toJson(), 'price': price, 'quantity': quantity};
  }

  static OrderItemRequest fromEntity(OrderEntityItemRequest entity) {
    return OrderItemRequest(
      product: ProductRequestDto(
        title: entity.productId,
        price: entity.price,
        description: '',
        category: '',

      ),
      price: entity.price,
      quantity: entity.quantity,
    );
  }
}
