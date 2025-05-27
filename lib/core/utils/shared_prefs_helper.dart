import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String _keyEmail = 'user_email';

  /// Save email
  static Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, email);
  }

  /// Get saved email
  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  /// Optional: Clear email
  static Future<void> clearEmail() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyEmail);
  }
}
