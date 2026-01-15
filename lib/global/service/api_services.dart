
//global/service/api_services.dart
import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constant/api_constant.dart';
import '../storage/storage_helper.dart';


class ApiService {
  /// POST Request
  static Future<dynamic> postRequest(String endpoint,
      {Map<String, dynamic>? body}) async {
    try {
      final token = await StorageHelper.getToken();
      final uri = Uri.parse("${ApiConstants.baseUrl}$endpoint");

      developer.log('📤 POST Request to: $uri', name: 'ApiService');
      developer.log('📦 Body: $body', name: 'ApiService');

      final response = await http.post(
        uri,
        headers: _headers(token),
        body: jsonEncode(body),
      );

      developer.log('📥 Response Status: ${response.statusCode}', name: 'ApiService');
      developer.log('📥 Response Body: ${response.body}', name: 'ApiService');

      return processResponse(response);
    } catch (e) {
      developer.log('❌ POST Error: $e', name: 'ApiService');
      throw Exception("POST request error: $e");
    }
  }

  /// GET Request
  static Future<dynamic> getRequest(String endpoint,
      {Map<String, String>? queryParams}) async {
    try {
      final token = await StorageHelper.getToken();
      final uri = Uri.parse("${ApiConstants.baseUrl}$endpoint")
          .replace(queryParameters: queryParams);

      developer.log('📤 GET Request to: $uri', name: 'ApiService');

      final response = await http.get(
        uri,
        headers: _headers(token),
      );

      developer.log('📥 Response Status: ${response.statusCode}', name: 'ApiService');
      developer.log('📥 Response Body: ${response.body}', name: 'ApiService');

      return processResponse(response);
    } catch (e) {
      developer.log('❌ GET Error: $e', name: 'ApiService');
      // throw Exception("$e");
    }
  }

  /// Multipart PUT request
  static Future<dynamic> putMultipartRequest(
      String endpoint, {
        Map<String, String>? fields,
        Map<String, File>? files,
        Map<String, Uint8List>? webFiles,
      }) async {
    try {
      final token = await StorageHelper.getToken();
      final uri = Uri.parse("${ApiConstants.baseUrl}$endpoint");

      var request = http.MultipartRequest('PUT', uri);

      final cleaned = token?.trim() ?? "";
      if (cleaned.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $cleaned';
      }

      if (fields != null) {
        request.fields.addAll(fields);
      }

      if (!kIsWeb && files != null) {
        for (var entry in files.entries) {
          final file = await http.MultipartFile.fromPath(
            entry.key,
            entry.value.path,
          );
          request.files.add(file);
        }
      }

      if (kIsWeb && webFiles != null) {
        for (var entry in webFiles.entries) {
          final file = http.MultipartFile.fromBytes(
            entry.key,
            entry.value,
            filename: 'profile_image.jpg',
          );
          request.files.add(file);
        }
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      return processResponse(response);
    } catch (e) {
      developer.log('❌ Multipart PUT Error: $e', name: 'ApiService');
      throw Exception("Multipart PUT request error: $e");
    }
  }

  /// Headers with Token
  static Map<String, String> _headers(String? token) {
    final cleaned = token?.trim() ?? "";
    final headers = <String, String>{
      "Content-Type": "application/json",
    };

    if (cleaned.isNotEmpty) {
      headers["Authorization"] = "Bearer $cleaned";
    }

    return headers;
  }

  /// ✅ Public Response Handler (previously _processResponse)
  static dynamic processResponse(http.Response response) {
    final statusCode = response.statusCode;

    if (statusCode >= 200 && statusCode < 305) {
      if (response.body.isNotEmpty) {
        try {
          return jsonDecode(response.body);
        } catch (e) {
          developer.log('⚠️ JSON decode error: $e', name: 'ApiService');
          return {"message": response.body};
        }
      } else {
        return {};
      }
    } else {
      developer.log('❌ HTTP Error ${response.statusCode}: ${response.body}', name: 'ApiService');
      throw Exception("Error ${response.statusCode}: ${response.body}");
    }
  }
}