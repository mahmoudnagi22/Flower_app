class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? phoneNumber;
  String? profileImage;
  String? passWord;
  String? role;
  List<dynamic>? wishlist;
  List<String>? addresses;
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
    passWord = json['password'];
    role = json['user']?['role'];
    wishlist = json['user']?['wishlist'] ?? [];
    addresses = List<String>.from(json['user']?['addresses'] ?? []);
    id = json['user']?['_id'];
    token = json['token'];
    createdAt =
        json['user']?['createdAt'] != null
            ? DateTime.parse(json['user']?['createdAt'])
            : null;
  }
}
