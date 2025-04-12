import '../../domain/entities/update_quantity_response_entity.dart';

class UpdateQuantityResponseDto extends UpdateQuantityResponseEntity {
  UpdateQuantityResponseDto({super.message, super.numOfCartItems, super.cart});

  UpdateQuantityResponseDto.fromJson(dynamic json) {
    message = json['message'];
    numOfCartItems = json['numOfCartItems'];
    cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['numOfCartItems'] = numOfCartItems;
    if (cart != null && cart is Cart) {
      map['cart'] = (cart as Cart).toJson();
    }
    return map;
  }
}

class Cart extends CartEntity {
  Cart({
    super.id,
    super.user,
    super.cartItems,
    super.discount,
    super.totalPrice,
    super.totalPriceAfterDiscount,
    super.createdAt,
    super.updatedAt,
    super.v,
  });

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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['user'] = user;
    if (cartItems != null) {
      map['cartItems'] = cartItems?.map((v) => (v as CartItems).toJson()).toList();
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

class CartItems extends CartItemsEntity {
  CartItems({super.product, super.price, super.quantity, super.id});

  CartItems.fromJson(dynamic json) {
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    price = json['price'];
    quantity = json['quantity'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (product != null && product is Product) {
      map['product'] = (product as Product).toJson();
    }
    map['price'] = price;
    map['quantity'] = quantity;
    map['_id'] = id;
    return map;
  }
}

class Product extends ProductEntity {
  Product({
    super.rateAvg,
    super.rateCount,
    super.id,
    super.title,
    super.slug,
    super.description,
    super.imgCover,
    super.images,
    super.price,
    super.priceAfterDiscount,
    super.quantity,
    super.category,
    super.occasion,
    super.createdAt,
    super.updatedAt,
    super.v,
    super.sold,
    super.discount,
  });

  Product.fromJson(dynamic json) {
    rateAvg = json['rateAvg'];
    rateCount = json['rateCount'];
    id = json['_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    imgCover = json['imgCover'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    price = json['price'];
    priceAfterDiscount = json['priceAfterDiscount'];
    quantity = json['quantity'];
    category = json['category'];
    occasion = json['occasion'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    sold = json['sold'];
    discount = json['discount'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rateAvg'] = rateAvg;
    map['rateCount'] = rateCount;
    map['_id'] = id;
    map['title'] = title;
    map['slug'] = slug;
    map['description'] = description;
    map['imgCover'] = imgCover;
    map['images'] = images;
    map['price'] = price;
    map['priceAfterDiscount'] = priceAfterDiscount;
    map['quantity'] = quantity;
    map['category'] = category;
    map['occasion'] = occasion;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['sold'] = sold;
    map['discount'] = discount;
    map['id'] = id;
    return map;
  }
}
