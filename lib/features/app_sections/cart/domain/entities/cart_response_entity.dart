class CartResponseEntity {
  CartResponseEntity({this.message, this.numOfCartItems, this.cart});

  String? message;
  num? numOfCartItems;
  CartEntity? cart;
}

class CartEntity {
  CartEntity({
    this.id,
    this.user,
    this.cartItems,
    this.discount,
    this.totalPrice,
    this.totalPriceAfterDiscount,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? user;
  List<CartItemsEntity>? cartItems;
  num? discount;
  num? totalPrice;
  num? totalPriceAfterDiscount;
  String? createdAt;
  String? updatedAt;
  num? v;
}

class CartItemsEntity {
  CartItemsEntity({this.product, this.price, this.quantity, this.id});

  ProductEntity? product;
  num? price;
  num? quantity;
  String? id;
}

class ProductEntity {
  ProductEntity({
    this.rateAvg,
    this.rateCount,
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.sold,
    this.discount,
  });

  num? rateAvg;
  num? rateCount;
  String? id;
  String? title;
  String? slug;
  String? description;
  String? imgCover;
  List<String>? images;
  num? price;
  num? priceAfterDiscount;
  num? quantity;
  String? category;
  String? occasion;
  String? createdAt;
  String? updatedAt;
  num? v;
  num? sold;
  num? discount;
}
