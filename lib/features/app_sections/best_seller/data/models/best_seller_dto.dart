import 'package:flower_app/features/app_sections/occasions/domain/entities/products_entity.dart';

class BestSellerDto extends ProductEntity {
  BestSellerDto({
    required String id,
    required String title,
    required String slug,
    required String description,
    required String imgCover,
    required List<String> images,
    required double price,
    required double priceAfterDiscount,
    required int quantity,
    required String category,
    required String occasion,
    required int rateAvg,
    required int rateCount,
    required int sold,

  }) : super(
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

    rateAvg: rateAvg,
    rateCount: rateCount,
    sold: sold,

  );

  factory BestSellerDto.fromJson(Map<String, dynamic> json) {
    return BestSellerDto(
      id: json['id'] ?? json['_id'] ?? '',
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      imgCover: json['imgCover'] ?? '',
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : <String>[],
      price: (json['price'] ?? 0).toDouble(),
      priceAfterDiscount: (json['priceAfterDiscount'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
      category: json['category'] ?? '',
      occasion: json['occasion'] ?? '',
      rateAvg: json['rateAvg'] ?? 0,
      rateCount: json['rateCount'] ?? 0,
      sold: json['sold'] ?? 0,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'description': description,
      'imgCover': imgCover,
      'images': images,
      'price': price,
      'priceAfterDiscount': priceAfterDiscount,
      'quantity': quantity,
      'category': category,
      'occasion': occasion,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'rateAvg': rateAvg,
      'rateCount': rateCount,
      'sold': sold,

    };
  }

  // هنا دالة لتحويل DTO إلى Entity
  ProductEntity toEntity() {
    return ProductEntity(
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
      rateAvg: rateAvg,
      rateCount: rateCount,
      sold: sold,
    );
  }

}

