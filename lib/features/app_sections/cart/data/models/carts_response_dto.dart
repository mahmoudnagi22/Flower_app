import '../../domain/entities/cart_response_entity.dart';

class CartsResponseDto extends CartResponseEntity {
  CartsResponseDto({super.message, super.numOfCartItems, super.cart});

  CartsResponseDto.fromJson(dynamic json) {
    message = json['message'];
    numOfCartItems = json['numOfCartItems'];
    cart = json['cart'] != null ? CartDto.fromJson(json['cart']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['numOfCartItems'] = numOfCartItems;
    if (cart != null && cart is CartDto) {
      map['cart'] = (cart as CartDto).toJson();
    }
    return map;
  }
}

class CartDto extends CartEntity {
  CartDto({
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

  CartDto.fromJson(dynamic json) {
    id = json['_id'];
    user = json['user'];
    if (json['cartItems'] != null) {
      cartItems = [];
      json['cartItems'].forEach((v) {
        cartItems?.add(CartItemsDto.fromJson(v));
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
      map['cartItems'] = cartItems?.map((v) => (v as CartItemsDto).toJson()).toList();
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

class CartItemsDto extends CartItemsEntity {
  CartItemsDto({super.product, super.price, super.quantity, super.id});

  CartItemsDto.fromJson(dynamic json) {
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

    return map;
  }
}
