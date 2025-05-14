import 'package:flower_app/features/checkout_page/data/dto/cash_dto/responses/product_dto_response.dart';

class CashOrderResponseEntity {
  final String id;
  final String user;
  final List<OrderEntityItemResponse> orderItems;
  final double totalPrice;
  final String paymentType;
  final bool isPaid;
  final bool isDelivered;
  final String state;
  final String orderNumber;
  final String createdAt;
  final String updatedAt;

  CashOrderResponseEntity({
    required this.id,
    required this.user,
    required this.orderItems,
    required this.totalPrice,
    required this.paymentType,
    required this.isPaid,
    required this.isDelivered,
    required this.state,
    required this.orderNumber,
    required this.createdAt,
    required this.updatedAt,
  });
}
  class OrderEntityItemResponse {
  final String id;
  final ProductResponseDto product;
  final double price;
  final int quantity;

  OrderEntityItemResponse({
  required this.id,
  required this.product,
  required this.price,
  required this.quantity,
  });
  }
