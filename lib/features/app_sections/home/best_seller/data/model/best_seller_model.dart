import 'package:flower_app/features/app_sections/home/best_seller/domain/entities/best_seller_product_entity.dart';

class ProductModel extends BestSellerProductEntity {
  ProductModel({
    required super.id,
    required super.title,
    required super.slug,
    required super.description,
    required super.imgCover,
    required super.images,
    required super.price,
    required super.priceAfterDiscount,
    required super.quantity,
    required super.category,
    required super.occasion,
    required super.createdAt,
    required super.updatedAt,
    required super.discount,
    required super.sold,
    required super.rateAvg,
    required super.rateCount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      imgCover: json['imageCover'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      price: json['price'] ?? 0,
      priceAfterDiscount: json['priceAfterDiscount'] ?? 0,
      quantity: json['quantity'] ?? 0,
      category: json['category'] ?? '',
      occasion: json['occasion'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      discount: json['discount'] ?? 0,
      sold: json['sold'] ?? 0,
      rateAvg: (json['ratingsAverage'] ?? 0).toDouble(),
      rateCount: json['ratingsQuantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'slug': slug,
      'description': description,
      'imageCover': imgCover,
      'images': images,
      'price': price,
      'priceAfterDiscount': priceAfterDiscount,
      'quantity': quantity,
      'category': category,
      'occasion': occasion,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'discount': discount,
      'sold': sold,
      'ratingsAverage': rateAvg,
      'ratingsQuantity': rateCount,
    };
  }

  BestSellerProductEntity toEntity() => BestSellerProductEntity(
    id: id,
    title: title,
    slug: slug,
    description: description,
    imgCover: imgCover,
    images: images,
    price: price,
    priceAfterDiscount: priceAfterDiscount,
    quantity: quantity,
    category: category,
    occasion: occasion,
    createdAt: createdAt,
    updatedAt: updatedAt,
    discount: discount,
    sold: sold,
    rateAvg: rateAvg,
    rateCount: rateCount,
  );
}
