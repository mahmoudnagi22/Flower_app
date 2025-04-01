class OccasionEntity {
  OccasionEntity({this.message, this.occasions});

  String? message;

  List<OccasionsEntity>? occasions;
}

class OccasionsEntity {
  OccasionsEntity({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.productsCount,
  });

  String? id;
  String? name;
  String? slug;
  String? image;
  String? createdAt;
  String? updatedAt;
  num? productsCount;
}
