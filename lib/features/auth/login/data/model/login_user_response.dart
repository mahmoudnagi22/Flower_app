class LoginUserResponse {
final String email;
final String password;
final bool rememberMe;
LoginUserResponse({required this.rememberMe, required this.email , required this.password});

Map<String,dynamic> toJson(){
  return {
    "email":email,
    "password":password
  };
}
}




// class LoginUserResponse {
//   final String email;
//   String? id;
//   String? firstName;
//   String? lastName;
//   String? gender;
//   String? phone;
//   String? photo;
//   String? role;
//   List<dynamic>? wishlist;
//   List<dynamic>? addresses;
//   String? createdAt;
//
//   LoginUserResponse({required this.email , required this.password,
//     this.id,
//     this.firstName,
//     this.lastName,
//     this.gender,
//     this.phone,
//     this.photo,
//     this.role,
//     this.wishlist,
//     this.addresses,
//     this.createdAt,
//
//   });
//
//   Map<String,dynamic> toJson(){
//     return {
//       "email":email,
//       "id":id,
//       "firstName":firstName,
//       "lastName":lastName,
//       "gender":gender,
//       "phone":phone,
//       "photo":photo,
//       "role":role,
//       "wishlist":wishlist,
//       "addresses":addresses,
//       "createdAt":createdAt,
//     };
//   }
// }