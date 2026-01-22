// lib/global/service/massage/massage_service.dart

import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../constant/api_constant.dart';
import '../../model/massage/massage_model.dart';
import '../../storage/storage_helper.dart';

class MessageService {
  /// Get Messages with Pagination
  static Future<MessageResponse> getMessages({int pageNumber = 1}) async {
    try {
      final token = await StorageHelper.getToken();
      final uri = Uri.parse(
          "${ApiConstants.baseUrl}/LongTermStudent/StudentMessages?pageNumber=$pageNumber"
      );

      developer.log('📤 GET Messages Request: $uri', name: 'MessageService');

      final response = await http.get(
        uri,
        headers: _headers(token),
      );

      developer.log('📥 Response Status: ${response.statusCode}', name: 'MessageService');
      developer.log('📥 Response Body: ${response.body}', name: 'MessageService');

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          // Return empty response
          final emptyData = MessageResponse(
            items: [],
            pageNumber: 1,
            pageSize: 10,
            totalCount: 0,
            totalPages: 0,
            hasNextPage: false,
            hasPreviousPage: false,
          );
          developer.log('⚠️ Empty response body', name: 'MessageService');
          return emptyData;
        }

        // Decode JSON properly
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        final data = MessageResponse.fromJson(jsonData);

        developer.log('✅ Messages Loaded: ${data.items.length}', name: 'MessageService');
        developer.log('📊 Page: ${data.pageNumber}/${data.totalPages}', name: 'MessageService');
        developer.log('📊 Total Count: ${data.totalCount}', name: 'MessageService');

        return data;
      } else {
        throw Exception('Failed to load messages: ${response.statusCode}');
      }
    } catch (e) {
      developer.log('❌ GET Messages Error: $e', name: 'MessageService');
      rethrow;
    }
  }

  /// Send Message with Optional File Attachment
  static Future<bool> sendMessage({
    required String subject,
    required String body,
    File? attachmentFile,
    Uint8List? webAttachment,
  }) async {
    try {
      final token = await StorageHelper.getToken();
      final uri = Uri.parse(
          "${ApiConstants.baseUrl}/LongTermStudent/StudentMessage"
      );

      developer.log('📤 POST Message Request: $uri', name: 'MessageService');
      developer.log('📝 Subject: $subject', name: 'MessageService');
      developer.log('📝 Body: $body', name: 'MessageService');

      var request = http.MultipartRequest('POST', uri);

      // Add Authorization Header
      final cleaned = token?.trim() ?? "";
      if (cleaned.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $cleaned';
      }

      // Add Form Fields
      request.fields['Subject'] = subject;
      request.fields['Body'] = body;

      // Add File Attachment (Mobile)
      if (!kIsWeb && attachmentFile != null) {
        final file = await http.MultipartFile.fromPath(
          'AttachmentFile',
          attachmentFile.path,
        );
        request.files.add(file);
        developer.log('📎 Attachment Added: ${attachmentFile.path}', name: 'MessageService');
      }

      // Add File Attachment (Web)
      if (kIsWeb && webAttachment != null) {
        final file = http.MultipartFile.fromBytes(
          'AttachmentFile',
          webAttachment,
          filename: 'attachment.pdf',
        );
        request.files.add(file);
        developer.log('📎 Web Attachment Added', name: 'MessageService');
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      developer.log('📥 Response Status: ${response.statusCode}', name: 'MessageService');
      developer.log('📥 Response Body: ${response.body}', name: 'MessageService');

      // Accept both 200 (OK) and 204 (No Content) as success
      if (response.statusCode == 200 || response.statusCode == 204) {
        developer.log('✅ Message Sent Successfully', name: 'MessageService');
        return true;
      } else {
        throw Exception('Failed to send message: ${response.statusCode}');
      }
    } catch (e) {
      developer.log('❌ Send Message Error: $e', name: 'MessageService');
      rethrow;
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
}