import 'package:flower_app/features/checkout_page/domain/entity/cash_order/response/product_response_entity.dart';

class ProductResponseDto extends ProductResponseEntity {
   ProductResponseDto({
    required String id,
    required String title,
    required String description,
    required double price,
    required double priceAfterDiscount,
    required String category,
  }) : super(
    id: id,
    title: title,
    description: description,
    price: price,
    category: category,
  );

  factory ProductResponseDto.fromJson(Map<String, dynamic> json) {
    return ProductResponseDto(
      id: json['id'],
      title: json['title'],  // Correctly mapping title from JSON
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      priceAfterDiscount: (json['priceAfterDiscount'] as num).toDouble(),
      category: json['category'],  // Correctly mapping category from JSON
    );
  }
}
