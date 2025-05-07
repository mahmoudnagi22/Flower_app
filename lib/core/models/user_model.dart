import 'package:flower_app/features/address/data/models/address.dart';

class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? phoneNumber;
  String? profileImage;
  String? role;
  List<dynamic>? wishlist;
  List<Address>? addresses;
  String? id;
  String? token;
  DateTime? createdAt;

  UserModel._();

  static final UserModel _singletonInstance = UserModel._();

  static UserModel get instance => _singletonInstance;

  void setFromJson(Map<String, dynamic> json) {
    firstName = json['user']?['firstName'];
    lastName = json['user']?['lastName'];
    email = json['user']?['email'];
    gender = json['user']?['gender'];
    phoneNumber = json['user']?['phone'];
    profileImage = json['user']?['photo'];
    role = json['user']?['role'];
    wishlist = json['user']?['wishlist'] ?? [];
    addresses = (json['user']?['addresses'] as List<dynamic>?)
        ?.map((item) => Address.fromJson(item))
        .toList() ?? [];
    id = json['user']?['_id'];
    token = json['token'];
    createdAt = json['user']?['createdAt'] != null
        ? DateTime.parse(json['user']?['createdAt'])
        : null;
  }
}
