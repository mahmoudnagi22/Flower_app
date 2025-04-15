import 'package:flower_app/features/edit_profile/domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  UserProfileModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phone,
    required super.gender,
    required super.imagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'gender': gender,
    };
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
      imagePath: json['profile_image'],
    );
  }
}
