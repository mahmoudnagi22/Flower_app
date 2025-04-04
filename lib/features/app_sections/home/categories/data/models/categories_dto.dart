import 'package:flower_app/features/app_sections/home/categories/domain/entities/categories_entity.dart';

class CategoriesDto extends CategoriesEntity {
  CategoriesDto({super.message, super.metadata, super.categoryList});

  CategoriesDto.fromJson(dynamic json) {
    message = json['message'];
    metadata =
        json['metadata'] != null
            ? MetadataDto.fromJson(json['metadata'])
            : null;
    if (json['categories'] != null) {
      categoryList = [];
      json['categories'].forEach((v) {
        categoryList?.add(CategoryDto.fromJson(v));
      });
    }
  }
}

class CategoryDto extends CategoryEntity {
  CategoryDto({
    super.id,
    super.name,
    super.slug,
    super.image,
    super.createdAt,
    super.updatedAt,
    super.productsCount,
  });

  CategoryDto.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    productsCount = json['productsCount'];
  }
}

class MetadataDto extends MetadataEntity {
  MetadataDto({
    super.currentPage,
    super.limit,
    super.totalPages,
    super.totalItems,
  });

  MetadataDto.fromJson(dynamic json) {
    currentPage = json['currentPage'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    totalItems = json['totalItems'];
  }
}
