import 'CartItems.dart';

class Cart {
  Cart({
      this.id, 
      this.user, 
      this.cartItems, 
      this.discount, 
      this.totalPrice, 
      this.totalPriceAfterDiscount, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Cart.fromJson(dynamic json) {
    id = json['_id'];
    user = json['user'];
    if (json['cartItems'] != null) {
      cartItems = [];
      json['cartItems'].forEach((v) {
        cartItems?.add(CartItems.fromJson(v));
      });
    }
    discount = json['discount'];
    totalPrice = json['totalPrice'];
    totalPriceAfterDiscount = json['totalPriceAfterDiscount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? user;
  List<CartItems>? cartItems;
  num? discount;
  num? totalPrice;
  num? totalPriceAfterDiscount;
  String? createdAt;
  String? updatedAt;
  num? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['user'] = user;
    if (cartItems != null) {
      map['cartItems'] = cartItems?.map((v) => v.toJson()).toList();
    }
    map['discount'] = discount;
    map['totalPrice'] = totalPrice;
    map['totalPriceAfterDiscount'] = totalPriceAfterDiscount;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}