// To parse this JSON data, do
//
//     final categoryByIdDto = categoryByIdDtoFromJson(jsonString);

import 'dart:convert';

import 'package:flower_app/features/app_sections/home/categories/domain/entities/category_by_id_entity.dart';

CategoriesByIdDto categoryByIdDtoFromJson(String str) =>
    CategoriesByIdDto.fromJson(json.decode(str));

class CategoriesByIdDto extends CategoriesByIdEntity {
  CategoriesByIdDto({super.message, super.category});

  factory CategoriesByIdDto.fromJson(Map<String, dynamic> json) =>
      CategoriesByIdDto(
        message: json["message"],
        category:
            json["category"] == null
                ? null
                : CategoryByIdDto.fromJson(json["category"]),
      );
}

class CategoryByIdDto extends CategoryByIdEntity {
  CategoryByIdDto({
    super.id,
    super.name,
    super.slug,
    super.image,
    super.createdAt,
    super.updatedAt,
  });

  factory CategoryByIdDto.fromJson(Map<String, dynamic> json) => CategoryByIdDto(
    id: json["_id"],
    name: json["name"],
    slug: json["slug"],
    image: json["image"],
  );
}
