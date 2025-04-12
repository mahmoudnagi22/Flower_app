class CategoriesByIdEntity {
  CategoriesByIdEntity({this.message, this.category});

  String? message;
  CategoryByIdEntity? category;
}

class CategoryByIdEntity {
  CategoryByIdEntity({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? name;
  String? slug;
  String? image;
  String? createdAt;
  String? updatedAt;
}
