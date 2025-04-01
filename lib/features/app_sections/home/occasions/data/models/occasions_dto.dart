import 'package:flower_app/features/app_sections/home/occasions/domain/entities/occasion_entity.dart';

class OccasionDto extends OccasionEntity {
  OccasionDto({super.message, super.occasions});

  OccasionDto.fromJson(dynamic json) {
    message = json['message'];
    if (json['occasions'] != null) {
      occasions = [];
      json['occasions'].forEach((v) {
        occasions?.add(OccasionsDto.fromJson(v));
      });
    }
  }
}

class OccasionsDto extends OccasionsEntity {
  OccasionsDto({
    super.id,
    super.name,
    super.slug,
    super.image,
    super.createdAt,
    super.updatedAt,
    super.productsCount,
  });

  OccasionsDto.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    productsCount = json['productsCount'];
  }
}

class Metadata {
  Metadata({this.currentPage, this.limit, this.totalPages, this.totalItems});

  Metadata.fromJson(dynamic json) {
    currentPage = json['currentPage'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    totalItems = json['totalItems'];
  }

  num? currentPage;
  num? limit;
  num? totalPages;
  num? totalItems;
}
