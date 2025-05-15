import 'package:flower_app/features/checkout_page/domain/entity/cash_order/request/product_entity_request.dart';
class ProductRequestDto extends ProductRequestEntity {
  ProductRequestDto({
    required String title,
    required String description,
    required double price,
    required String category,
  }) : super(
    title: title,
    description: description,
    price: price,
    category: category,
  );

  factory ProductRequestDto.fromJson(Map<String, dynamic> json) {
    return ProductRequestDto(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title ?? '',
      'description': description ?? '',
      'price': price ?? 0,
      'category': category ?? '',
    };
  }

  static ProductRequestDto fromEntity(ProductRequestEntity entity) {
    return ProductRequestDto(
      title: entity.title ?? '',
      description: entity.description ?? '',
      price: (entity.price ?? 0).toDouble(),
      category: entity.category ?? '',
    );
  }
}
