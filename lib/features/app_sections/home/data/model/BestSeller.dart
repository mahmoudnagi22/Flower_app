class BestSeller {
  BestSeller({
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
      this.discount, 
      this.sold, 
      this.rateAvg, 
      this.rateCount,});

  BestSeller.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    imgCover = json['imgCover'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    price = json['price'];
    priceAfterDiscount = json['priceAfterDiscount'];
    quantity = json['quantity'];
    category = json['category'];
    occasion = json['occasion'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    discount = json['discount'];
    sold = json['sold'];
    rateAvg = json['rateAvg'];
    rateCount = json['rateCount'];
  }
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
  num? discount;
  num? sold;
  num? rateAvg;
  num? rateCount;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['title'] = title;
    map['slug'] = slug;
    map['description'] = description;
    map['imgCover'] = imgCover;
    map['images'] = images;
    map['price'] = price;
    map['priceAfterDiscount'] = priceAfterDiscount;
    map['quantity'] = quantity;
    map['category'] = category;
    map['occasion'] = occasion;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['discount'] = discount;
    map['sold'] = sold;
    map['rateAvg'] = rateAvg;
    map['rateCount'] = rateCount;
    return map;
  }

}