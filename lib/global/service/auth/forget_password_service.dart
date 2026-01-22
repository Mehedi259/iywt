// lib/global/service/auth/forget_password_service.dart

import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

class ForgotPasswordService {
  /// Send password reset email
  static Future<Map<String, dynamic>> sendResetPasswordEmail(String email) async {
    try {
      // Using standard POST request instead of multipart
      final uri = Uri.parse('https://world-stg.iywt.com/portal/Identity/Account/ForgotPassword');

      developer.log('📤 POST Request to: $uri', name: 'ForgotPasswordService');
      developer.log('📦 Email: $email', name: 'ForgotPasswordService');

      // Try with standard form-urlencoded instead of multipart
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'Email': email,
        },
      );

      developer.log('📥 Response Status: ${response.statusCode}', name: 'ForgotPasswordService');
      developer.log('📥 Response Body: ${response.body}', name: 'ForgotPasswordService');
      developer.log('📥 Response Headers: ${response.headers}', name: 'ForgotPasswordService');

      // Handle 302 redirect or 200 success
      if (response.statusCode == 200 || response.statusCode == 302) {
        // 302 means redirect, which typically means success for password reset
        return {
          'success': true,
          'message': 'Password reset link sent to your email!',
          'data': response.body,
        };
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        // Client error
        String errorMessage = 'Failed to send reset email';

        try {
          final errorBody = jsonDecode(response.body);
          errorMessage = errorBody['message'] ?? errorMessage;
        } catch (e) {
          // If not JSON, use the body as is
          if (response.body.isNotEmpty) {
            errorMessage = response.body;
          }
        }

        return {
          'success': false,
          'message': errorMessage,
          'error': response.body,
        };
      } else {
        return {
          'success': false,
          'message': response.reasonPhrase ?? 'Something went wrong',
          'error': response.body,
        };
      }
    } catch (e) {
      developer.log('❌ Forgot Password Error: $e', name: 'ForgotPasswordService');
      return {
        'success': false,
        'message': 'Network error. Please check your internet connection.',
        'error': e.toString(),
      };
    }
  }

  /// Alternative method using JSON body (if the above doesn't work)
  static Future<Map<String, dynamic>> sendResetPasswordEmailJson(String email) async {
    try {
      final uri = Uri.parse('https://world-stg.iywt.com/portal/Identity/Account/ForgotPassword');

      developer.log('📤 POST Request (JSON) to: $uri', name: 'ForgotPasswordService');
      developer.log('📦 Email: $email', name: 'ForgotPasswordService');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'Email': email,
        }),
      );

      developer.log('📥 Response Status: ${response.statusCode}', name: 'ForgotPasswordService');
      developer.log('📥 Response Body: ${response.body}', name: 'ForgotPasswordService');

      if (response.statusCode == 200 || response.statusCode == 302) {
        return {
          'success': true,
          'message': 'Password reset link sent to your email!',
          'data': response.body,
        };
      } else {
        return {
          'success': false,
          'message': response.reasonPhrase ?? 'Failed to send reset email',
          'error': response.body,
        };
      }
    } catch (e) {
      developer.log('❌ Forgot Password Error: $e', name: 'ForgotPasswordService');
      return {
        'success': false,
        'message': 'Network error. Please check your internet connection.',
        'error': e.toString(),
      };
    }
  }
}