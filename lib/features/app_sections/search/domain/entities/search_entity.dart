class SearchEntity {
  SearchEntity({this.message, this.products});

  String? message;
  List<ProductSearchEntity>? products;

  factory SearchEntity.fromJson(Map<String, dynamic> json) {
    return SearchEntity(
      message: json['message'],
      products: json['products'] != null
          ? List<ProductSearchEntity>.from(
        json['products'].map((x) => ProductSearchEntity.fromJson(x)),
      )
          : [],
    );
  }
}

class ProductSearchEntity {
  ProductSearchEntity({
    this.rateAvg,
    this.rateCount,
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.sold,
    this.discount,
  });

  num? rateAvg;
  num? rateCount;
  String? id;
  String? title;
  String? slug;
  String? description;
  String? imgCover;
  List<String>? images;
  num? price;
  num? priceAfterDiscount;
  num? quantity;
  String? category;
  String? occasion;
  String? createdAt;
  String? updatedAt;
  num? v;
  num? sold;
  num? discount;

  factory ProductSearchEntity.fromJson(Map<String, dynamic> json) {
    return ProductSearchEntity(
      rateAvg: json['rateAvg'],
      rateCount: json['rateCount'],
      id: json['_id'],
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
      imgCover: json['imgCover'],
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : [],
      price: json['price'],
      priceAfterDiscount: json['priceAfterDiscount'],
      quantity: json['quantity'],
      category: json['category'],
      occasion: json['occasion'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      sold: json['sold'],
      discount: json['discount'],
    );
  }
}
