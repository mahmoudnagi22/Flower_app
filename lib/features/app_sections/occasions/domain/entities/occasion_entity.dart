class OccasionEntity {
  OccasionEntity({this.message, this.occasions});

  String? message;
   String? categoryId;
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
    this.categoryId
  });
  String? categoryId;
  String? id;
  String? name;
  String? slug;
  String? image;
  String? createdAt;
  String? updatedAt;
  num? productsCount;
}
