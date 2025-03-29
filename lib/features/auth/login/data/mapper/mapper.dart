
import '../model/User.dart';

extension UserMapper on User {
  User userToUserEntities() => User(id: id, email: email , addresses: addresses ,createdAt: createdAt ,firstName: firstName,gender: gender,lastName: lastName,phone: phone,photo: photo,role: role,wishlist: wishlist);
}
