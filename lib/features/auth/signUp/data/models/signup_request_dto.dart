import 'package:flower_app/features/auth/signUp/domain/entities/signup_request_entity.dart';

class SignupRequestDto extends SignupRequestEntity {
  SignupRequestDto({
    super.firstName,
    super.lastName,
    super.email,
    super.password,
    super.rePassword,
    super.phone,
    super.gender,
  });

  SignupRequestDto.fromJson(dynamic json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    rePassword = json['rePassword'];
    phone = json['phone'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['password'] = password;
    map['rePassword'] = rePassword;
    map['phone'] = phone;
    map['gender'] = gender;
    return map;
  }
}
