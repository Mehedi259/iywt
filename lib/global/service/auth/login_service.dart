// lib/global/service/auth/login_service.dart
import 'dart:developer' as developer;
import '../../constant/api_constant.dart';
import '../../storage/storage_helper.dart';
import '../api_services.dart';

class LoginService {
  /// Login API call
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      developer.log('🔐 Attempting login for: $email', name: 'LoginService');

      final response = await ApiService.postRequest(
        ApiConstants.login,
        body: {
          "email": email,
          "password": password,
        },
      );

      developer.log('✅ Login successful', name: 'LoginService');

      // Extract and save token
      if (response != null && response['token'] != null) {
        final token = response['token']['result'];
        if (token != null && token.isNotEmpty) {
          await StorageHelper.saveToken(token);
          developer.log('💾 Token saved successfully', name: 'LoginService');
        }
      }

      return {
        'success': true,
        'data': response,
      };
    } catch (e) {
      developer.log('❌ Login failed: $e', name: 'LoginService');
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Logout
  static Future<void> logout() async {
    await StorageHelper.clearToken();
    developer.log('👋 User logged out', name: 'LoginService');
  }
}