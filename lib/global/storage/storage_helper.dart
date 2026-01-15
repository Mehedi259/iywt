//lib/global/storage/storage_helper.dart
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static const String _tokenKey = "access_token";

  /// Save Token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    // Trim whitespace/newlines before saving
    final safe = token.trim();
    await prefs.setString(_tokenKey, safe);
  }

  /// Get Token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    return token?.trim();
  }

  /// Clear Token (Logout)
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}