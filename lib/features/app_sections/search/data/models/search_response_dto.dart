import 'dart:convert';

import 'package:flower_app/features/app_sections/search/domain/entities/search_entity.dart';

SearchDto searchDtoFromJson(String str) => SearchDto.fromJson(json.decode(str));

class SearchDto extends SearchEntity {
  final Metadata? metadata;
  final List<ProductSearchDto>? products;

  SearchDto({super.message, this.metadata, this.products});

  factory SearchDto.fromJson(Map<String, dynamic> json) => SearchDto(
    message: json["message"],
    metadata:
        json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
    products:
        json["products"] == null
            ? []
            : List<ProductSearchDto>.from(
              json["products"]!.map((x) => ProductSearchDto.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "metadata": metadata?.toJson(),
    "products":
        products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Metadata {
  final int? currentPage;
  final int? totalPages;
  final int? limit;
  final int? totalItems;

  Metadata({this.currentPage, this.totalPages, this.limit, this.totalItems});

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
    limit: json["limit"],
    totalItems: json["totalItems"],
  );

  Map<String, dynamic> toJson() => {
    "currentPage": currentPage,
    "totalPages": totalPages,
    "limit": limit,
    "totalItems": totalItems,
  };
}

class ProductSearchDto extends ProductSearchEntity {
  ProductSearchDto({
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

  factory ProductSearchDto.fromJson(Map<String, dynamic> json) => ProductSearchDto(
    rateAvg: json["rateAvg"],
    rateCount: json["rateCount"],
    id: json["_id"],
    title: json["title"],
    slug: json["slug"],
    description: json["description"] is String
        ? json["description"]
        : (json["description"] as List).join(", "),
    imgCover: json["imgCover"],
    images:
        json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
    price: json["price"],
    priceAfterDiscount: json["priceAfterDiscount"],
    quantity: json["quantity"],
    category: json["category"],
    occasion: json["occasion"],
    v: json["__v"],
    sold: json["sold"],
    discount: json["discount"],
  );

  Map<String, dynamic> toJson() => {
    "rateAvg": rateAvg,
    "rateCount": rateCount,
    "id": id,
    "title": title,
    "slug": slug,
    "description": description,
    "imgCover": imgCover,
    "images": images == null ? [] : List<String>.from(images!.map((x) => x)),
    "price": price,
    "priceAfterDiscount": priceAfterDiscount,
    "quantity": quantity,
    "category": category,
    "occasion": occasion,
    "__v": v,
    "sold": sold,
    "discount": discount,
  };
}
