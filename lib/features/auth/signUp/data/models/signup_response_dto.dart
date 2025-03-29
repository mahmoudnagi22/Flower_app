import 'package:flower_app/features/auth/signUp/domain/entities/signup_response_entity.dart';

class SignupResponseDto extends SignupResponseEntity {
  SignupResponseDto({
    super.message,
    super.user,
    super.token,
  });

  SignupResponseDto.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? UserDto.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = (user as UserDto).toJson();
    }
    map['token'] = token;
    return map;
  }
}

class UserDto extends UserEntity {
  UserDto({
    super.firstName,
    super.lastName,
    super.email,
    super.gender,
    super.phone,
    super.photo,
    super.role,
    super.wishlist,
    super.id,
    super.addresses,
    super.createdAt,
  });

  UserDto.fromJson(dynamic json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    gender = json['gender'];
    phone = json['phone'];
    photo = json['photo'];
    role = json['role'];
    wishlist =
        json['wishlist'] != null ? List<dynamic>.from(json['wishlist']) : [];
    id = json['_id'];
    addresses =
        json['addresses'] != null ? List<dynamic>.from(json['addresses']) : [];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['gender'] = gender;
    map['phone'] = phone;
    map['photo'] = photo;
    map['role'] = role;
    map['wishlist'] = wishlist;
    map['_id'] = id;
    map['addresses'] = addresses;
    map['createdAt'] = createdAt;
    return map;
  }
}
