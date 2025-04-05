import 'package:flower_app/features/app_sections/home/occasions/domain/entities/occasion_by_id_entity.dart';

class OccasionsByIdDto extends OccasionsByIdEntity {
  OccasionsByIdDto({super.message, super.occasion});

  OccasionsByIdDto.fromJson(dynamic json) {
    message = json['message'];
    occasion =
        json['occasion'] != null
            ? OccasionByIdDto.fromJson(json['occasion'])
            : null;
  }
}

class OccasionByIdDto extends OccasionByIdEntity {
  OccasionByIdDto({
    super.id,
    super.name,
    super.slug,
    super.image,
    super.createdAt,
    super.updatedAt,
  });

  OccasionByIdDto.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}
