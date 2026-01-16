// lib/global/service/settings/email_service.dart

import 'package:flutter/foundation.dart';
import '../../constant/api_constant.dart';
import '../../model/settings/email_model.dart';
import '../api_services.dart';

class EmailService {
  // Get all emails
  static Future<List<EmailModel>> getEmails() async {
    try {
      final response = await ApiService.getRequest(ApiConstants.studentEmails);
      if (response != null && response is List) {
        return response.map((json) => EmailModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error fetching emails: $e');
      return [];
    }
  }

  // Update email by ID using PATCH
  static Future<bool> updateEmail(String emailId, EmailModel email) async {
    try {
      await ApiService.patchRequest(
        ApiConstants.studentEmailById(emailId),
        body: email.toJson(),
      );
      return true;
    } catch (e) {
      debugPrint('Error updating email: $e');
      return false;
    }
  }
}
