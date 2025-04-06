import 'package:flower_app/features/app_sections/home/occasions/domain/entities/products_entity.dart';

class ProductsDto extends ProductsEntity {
  ProductsDto({super.message, this.metadata, super.products});

  ProductsDto.fromJson(dynamic json) {
    message = json['message'];
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(ProductDto.fromJson(v));
      });
    }
  }

  Metadata? metadata;
}

class ProductDto extends ProductEntity {
  ProductDto({
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
    super.discount,
    super.sold,
    super.rateAvg,
    super.rateCount,
  });

  ProductDto.fromJson(dynamic json) {
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
    discount = json['discount'];
    sold = json['sold'];
    rateAvg = json['rateAvg'];
    rateCount = json['rateCount'];
    id = json['id'];
  }
}

class Metadata {
  Metadata({this.currentPage, this.totalPages, this.limit, this.totalItems});

  Metadata.fromJson(dynamic json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    limit = json['limit'];
    totalItems = json['totalItems'];
  }

  num? currentPage;
  num? totalPages;
  num? limit;
  num? totalItems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentPage'] = currentPage;
    map['totalPages'] = totalPages;
    map['limit'] = limit;
    map['totalItems'] = totalItems;
    return map;
  }
}
