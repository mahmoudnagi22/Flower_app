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

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "gender": gender,
    "imagePath": imagePath,
  };
}
