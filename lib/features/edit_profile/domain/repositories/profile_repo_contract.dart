import 'package:flower_app/core/models/user_model.dart';

abstract class EditProfileRepoContract {
  Future<UserModel> updateUserProfile(UserModel userModel, String token);
}
