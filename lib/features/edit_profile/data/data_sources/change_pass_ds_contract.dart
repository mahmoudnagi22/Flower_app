abstract class ChangePassDsContract {
  Future<void> changePassword({
    required String token,
    required String currentPassword,
    required String newPassword,
  });
}
