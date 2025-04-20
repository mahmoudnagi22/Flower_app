import '../../../cart/data/models/carts_response_dto.dart';
import 'Product.dart';

class CartItems {
  CartItems({
      this.product, 
      this.price, 
      this.quantity, 
      this.id,});

  CartItems.fromJson(dynamic json) {
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    price = json['price'];
    quantity = json['quantity'];
    id = json['_id'];
  }
  Product? product;
  num? price;
  num? quantity;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (product != null) {
      map['product'] = product?.toJson();
    }
    map['price'] = price;
    map['quantity'] = quantity;
    map['_id'] = id;
    return map;
  }

}