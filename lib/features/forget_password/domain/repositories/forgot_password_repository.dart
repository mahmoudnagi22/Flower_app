import 'package:dio/dio.dart';

class AuthRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://flower.elevateegy.com/api/v1/auth'));

  Future<void> sendResetEmail(String email) async {
    if (email.isEmpty || !email.contains('@')) {
      throw Exception("Enter a valid email");
    }
    try {
      await _dio.post('/forgotPassword', data: {"email": email});
    } catch (e) {
      throw Exception("Email not found");
    }
  }

  Future<void> verifyResetCode(String code) async {
    if (code.isEmpty || code.length < 4) {
      throw Exception("Enter a valid verification code");
    }
    try {
      await _dio.post('/verifyResetCode', data: {"resetCode": code});
    } catch (e) {
      throw Exception("Invalid verification code");
    }
  }

  Future<void> resetPassword(String email, String newPassword) async {
    if (newPassword.isEmpty || newPassword.length < 6) {
      throw Exception("Password must be at least 6 characters long");
    }
    try {
      await _dio.put('/resetPassword', data: {"email": email, "newPassword": newPassword});
    } catch (e) {
      throw Exception("Failed to reset password");
    }
  }
}
