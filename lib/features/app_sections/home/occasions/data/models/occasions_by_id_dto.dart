import '../../domain/entities/occasion_by_id_entity.dart';

class OccasionsByIdDto extends OccasionsByIdEntity {
  OccasionsByIdDto({super.message, super.occasion});

  OccasionsByIdDto.fromJson(dynamic json) {
    message = json['message'];
    occasion =
        json['occasion'] != null
            ? oneOccasionByIdDto.fromJson(json['occasion'])
            : null;
  }
}

class oneOccasionByIdDto extends OccasionByIdEntity {
  oneOccasionByIdDto({
    super.id,
    super.name,
    super.slug,
    super.image,
    super.createdAt,
    super.updatedAt,
  });

  oneOccasionByIdDto.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['image'] = image;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}
