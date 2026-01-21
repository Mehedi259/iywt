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
      final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.documentsDashboard}");

      developer.log('📤 GET Request to: $uri', name: 'DocumentsService');

      final response = await http.get(uri, headers: _headers(token));

      developer.log('📥 Response Status: ${response.statusCode}', name: 'DocumentsService');
      developer.log('📥 Response Body: ${response.body}', name: 'DocumentsService');

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
      final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.documentTypeList(type)}");

      developer.log('📤 GET Request to: $uri', name: 'DocumentsService');

      final response = await http.get(uri, headers: _headers(token));

      developer.log('📥 Response Status: ${response.statusCode}', name: 'DocumentsService');
      developer.log('📥 Response Body: ${response.body}', name: 'DocumentsService');

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
      final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.documentDetail(documentId)}");

      developer.log('📤 GET Request to: $uri', name: 'DocumentsService');

      final response = await http.get(uri, headers: _headers(token));

      developer.log('📥 Response Status: ${response.statusCode}', name: 'DocumentsService');
      developer.log('📥 Response Body: ${response.body}', name: 'DocumentsService');

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
      final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.documentUpload(documentId)}");

      developer.log('📤 POST Multipart Request to: $uri', name: 'DocumentsService');

      var request = http.MultipartRequest('POST', uri);

      final cleaned = token?.trim() ?? "";
      if (cleaned.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $cleaned';
      }

      request.fields['Description'] = description;

      if (!kIsWeb && documentFile != null) {
        final file = await http.MultipartFile.fromPath('DocumentFile', documentFile.path);
        request.files.add(file);
      }

      if (kIsWeb && webFile != null) {
        final file = http.MultipartFile.fromBytes(
          'DocumentFile',
          webFile,
          filename: 'uploaded_document.pdf',
        );
        request.files.add(file);
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      developer.log('📥 Response Status: ${response.statusCode}', name: 'DocumentsService');
      developer.log('📥 Response Body: ${response.body}', name: 'DocumentsService');

      return _processResponse(response);
    } catch (e) {
      developer.log('❌ Upload Error: $e', name: 'DocumentsService');
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
          developer.log('⚠️ JSON decode error: $e', name: 'DocumentsService');
          return {"message": response.body};
        }
      } else {
        return {};
      }
    } else {
      developer.log('❌ HTTP Error ${response.statusCode}: ${response.body}', name: 'DocumentsService');
      throw Exception("Error ${response.statusCode}: ${response.body}");
    }
  }
}