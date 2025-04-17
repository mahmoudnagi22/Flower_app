class CategoriesEntity {
  CategoriesEntity({this.message, this.metadata, this.categoryList});

  String? message;
  MetadataEntity? metadata;
  List<CategoryEntity>? categoryList;
}

class CategoryEntity {
  CategoryEntity({
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

class MetadataEntity {
  MetadataEntity({this.currentPage, this.limit, this.totalPages, this.totalItems});

  num? currentPage;
  num? limit;
  num? totalPages;
  num? totalItems;
}
