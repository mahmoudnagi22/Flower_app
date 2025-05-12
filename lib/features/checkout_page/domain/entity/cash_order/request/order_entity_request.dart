import 'package:flower_app/features/app_sections/cart/domain/entities/cart_response_entity.dart';

class CashOrderRequestEntity {
  final String user;
  final List<OrderEntityItemRequest> orderItems;
  final double totalPrice;
  final String paymentType;
  final bool isPaid;
  final bool isDelivered;
  final String state;
  final String orderNumber;
  final String createdAt;
  final String updatedAt;

  CashOrderRequestEntity({
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

class OrderEntityItemRequest {
  final String productId;
  final double price;
  final int quantity;

  OrderEntityItemRequest({
    required this.productId,
    required this.price,
    required this.quantity,
  });


}
List<OrderEntityItemRequest> mapCartToOrderItems(List<CartItemsEntity> cartItems) {
  return cartItems.map((item) {
    return OrderEntityItemRequest(
      productId: item.id ?? '',
      price: (item.price ?? 0).toDouble(),
      quantity: (item.quantity ?? 1).toInt(),
    );
  }).toList();
}

