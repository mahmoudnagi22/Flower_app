class SignupRequestEntity {
  SignupRequestEntity({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.rePassword,
    this.phone,
    this.gender,
  });

  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? rePassword;
  String? phone;
  String? gender;
}
