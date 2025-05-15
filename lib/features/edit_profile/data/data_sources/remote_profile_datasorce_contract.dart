import 'package:flower_app/core/models/user_model.dart';

abstract class RemoteProfileDatasorceContract {
  Future<UserModel> updateProfile(UserModel userProfile, String token);
}
