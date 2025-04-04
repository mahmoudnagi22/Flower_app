// To parse this JSON data, do
//
//     final categoryByIdDto = categoryByIdDtoFromJson(jsonString);

import 'dart:convert';

import 'package:flower_app/features/app_sections/home/categories/domain/entities/category_by_id_entity.dart';

CategoryByIdDto categoryByIdDtoFromJson(String str) =>
    CategoryByIdDto.fromJson(json.decode(str));

class CategoryByIdDto extends CategoriesByIdEntity {
  CategoryByIdDto({super.message, super.category});

  factory CategoryByIdDto.fromJson(Map<String, dynamic> json) =>
      CategoryByIdDto(
        message: json["message"],
        category:
            json["category"] == null
                ? null
                : CategoryDto.fromJson(json["category"]),
      );
}

class CategoryDto extends CategoryByIdEntity {
  CategoryDto({
    super.id,
    super.name,
    super.slug,
    super.image,
    super.createdAt,
    super.updatedAt,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) => CategoryDto(
    id: json["_id"],
    name: json["name"],
    slug: json["slug"],
    image: json["image"],
  );
}
