import 'Cart.dart';

class AddToCartResponse {
  AddToCartResponse({
      this.message, 
      this.numOfCartItems, 
      this.cart,});

  AddToCartResponse.fromJson(dynamic json) {
    message = json['message'];
    numOfCartItems = json['numOfCartItems'];
    cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
  }
  String? message;
  num? numOfCartItems;
  Cart? cart;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['numOfCartItems'] = numOfCartItems;
    if (cart != null) {
      map['cart'] = cart?.toJson();
    }
    return map;
  }

}