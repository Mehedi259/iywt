// lib/global/service/documents/documents_service.dart

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import '../../constant/api_constant.dart';
import '../../storage/storage_helper.dart';
import '../../model/documents/documents_model.dart';

class DocumentsService {
  /// Get Documents Dashboard
  static Future<DocumentsDashboard> getDocumentsDashboard() async {
    try {
      final token = await StorageHelper.getToken();
      final uri = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.documentsDashboard}");

      developer.log('📤 GET Request to: $uri', name: 'DocumentsService');

      final response = await http.get(uri, headers: _headers(token));

      developer.log('📥 Response Status: ${response.statusCode}',
          name: 'DocumentsService');
      developer.log('📥 Response Body: ${response.body}',
          name: 'DocumentsService');

      final data = _processResponse(response);
      return DocumentsDashboard.fromJson(data);
    } catch (e) {
      developer.log('❌ GET Error: $e', name: 'DocumentsService');
      throw Exception("Failed to fetch documents dashboard: $e");
    }
  }

  /// Get Document Type List (Preliminary, Student, Country)
  static Future<DocumentTypeList> getDocumentTypeList(String type) async {
    try {
      final token = await StorageHelper.getToken();
      final uri = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.documentTypeList(type)}");

      developer.log('📤 GET Request to: $uri', name: 'DocumentsService');

      final response = await http.get(uri, headers: _headers(token));

      developer.log('📥 Response Status: ${response.statusCode}',
          name: 'DocumentsService');
      developer.log('📥 Response Body: ${response.body}',
          name: 'DocumentsService');

      final data = _processResponse(response);
      return DocumentTypeList.fromJson(data);
    } catch (e) {
      developer.log('❌ GET Error: $e', name: 'DocumentsService');
      throw Exception("Failed to fetch document type list: $e");
    }
  }

  /// Get Document Detail
  static Future<DocumentDetail> getDocumentDetail(String documentId) async {
    try {
      final token = await StorageHelper.getToken();
      final uri = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.documentDetail(documentId)}");

      developer.log('📤 GET Request to: $uri', name: 'DocumentsService');

      final response = await http.get(uri, headers: _headers(token));

      developer.log('📥 Response Status: ${response.statusCode}',
          name: 'DocumentsService');
      developer.log('📥 Response Body: ${response.body}',
          name: 'DocumentsService');

      final data = _processResponse(response);
      return DocumentDetail.fromJson(data);
    } catch (e) {
      developer.log('❌ GET Error: $e', name: 'DocumentsService');
      throw Exception("Failed to fetch document detail: $e");
    }
  }

  /// Upload Document
  static Future<dynamic> uploadDocument({
    required String documentId,
    required String description,
    File? documentFile,
    Uint8List? webFile,
  }) async {
    try {
      final token = await StorageHelper.getToken();
      final uri = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.documentUpload(documentId)}");

      developer.log('📤 POST Multipart Request to: $uri',
          name: 'DocumentsService');
      developer.log('📝 Description: $description', name: 'DocumentsService');

      var request = http.MultipartRequest('POST', uri);

      // Add Authorization header
      final cleaned = token?.trim() ?? "";
      if (cleaned.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $cleaned';
        developer.log('🔑 Authorization header added',
            name: 'DocumentsService');
      } else {
        developer.log('⚠️ No token found!', name: 'DocumentsService');
      }

      // Add description field
      request.fields['Description'] = description;
      developer.log('📝 Fields added: ${request.fields}',
          name: 'DocumentsService');

      // Add file for mobile platforms
      if (!kIsWeb && documentFile != null) {
        if (await documentFile.exists()) {
          final fileSize = await documentFile.length();
          developer.log('📁 Adding file: ${documentFile.path}',
              name: 'DocumentsService');
          developer.log('📏 File size: $fileSize bytes',
              name: 'DocumentsService');

          final file = await http.MultipartFile.fromPath(
            'DocumentFile',
            documentFile.path,
            // You can add content type if needed
            // contentType: MediaType('application', 'pdf'),
          );
          request.files.add(file);
          developer.log('✅ File added to request', name: 'DocumentsService');
        } else {
          developer.log('❌ File does not exist: ${documentFile.path}',
              name: 'DocumentsService');
          throw Exception('File does not exist');
        }
      }

      // Add file for web platform
      if (kIsWeb && webFile != null) {
        developer.log('🌐 Adding web file (${webFile.length} bytes)',
            name: 'DocumentsService');

        final file = http.MultipartFile.fromBytes(
          'DocumentFile',
          webFile,
          filename: 'uploaded_document.pdf',
        );
        request.files.add(file);
        developer.log('✅ Web file added to request',
            name: 'DocumentsService');
      }

      // Debug: Print all request details
      developer.log('🔍 Request details:', name: 'DocumentsService');
      developer.log('   URL: ${request.url}', name: 'DocumentsService');
      developer.log('   Method: ${request.method}', name: 'DocumentsService');
      developer.log('   Headers: ${request.headers}',
          name: 'DocumentsService');
      developer.log('   Fields: ${request.fields}', name: 'DocumentsService');
      developer.log('   Files: ${request.files.length}',
          name: 'DocumentsService');

      if (request.files.isNotEmpty) {
        for (var file in request.files) {
          developer.log(
              '   File - Field: ${file.field}, Filename: ${file.filename}, Length: ${file.length}',
              name: 'DocumentsService');
        }
      }

      developer.log('🚀 Sending request...', name: 'DocumentsService');

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      developer.log('📥 Response Status: ${response.statusCode}',
          name: 'DocumentsService');
      developer.log('📥 Response Body: ${response.body}',
          name: 'DocumentsService');
      developer.log('📥 Response Headers: ${response.headers}',
          name: 'DocumentsService');

      return _processResponse(response);
    } catch (e, stackTrace) {
      developer.log('❌ Upload Error: $e',
          name: 'DocumentsService', error: e, stackTrace: stackTrace);
      throw Exception("Failed to upload document: $e");
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

  /// Response Handler
  static dynamic _processResponse(http.Response response) {
    final statusCode = response.statusCode;

    if (statusCode >= 200 && statusCode < 305) {
      if (response.body.isNotEmpty) {
        try {
          return jsonDecode(response.body);
        } catch (e) {
          developer.log('⚠️ JSON decode error: $e',
              name: 'DocumentsService');
          return {"message": response.body};
        }
      } else {
        return {};
      }
    } else {
      developer.log('❌ HTTP Error ${response.statusCode}: ${response.body}',
          name: 'DocumentsService');
      throw Exception("Error ${response.statusCode}: ${response.body}");
    }
  }
}