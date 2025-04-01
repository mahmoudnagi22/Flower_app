class User {
  User({
      this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.gender,
      this.phone,
      this.photo,
      this.role,
      this.wishlist,
      this.addresses,
      this.createdAt,});

  User.fromJson(dynamic json) {
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    gender = json['gender'];
    phone = json['phone'];
    photo = json['photo'];
    role = json['role'];
    if (json['wishlist'] != null) {
      wishlist = [];
      json['wishlist'].forEach((v) {
        wishlist?.add(v.fromJson(v));
      });
    }
    if (json['addresses'] != null) {
      addresses = [];
      json['addresses'].forEach((v) {
        addresses?.add(v.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
  }
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? phone;
  String? photo;
  String? role;
  List<dynamic>? wishlist;
  List<dynamic>? addresses;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['gender'] = gender;
    map['phone'] = phone;
    map['photo'] = photo;
    map['role'] = role;
    if (wishlist != null) {
      map['wishlist'] = wishlist?.map((v) => v.toJson()).toList();
    }
    if (addresses != null) {
      map['addresses'] = addresses?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = createdAt;
    return map;
  }

}