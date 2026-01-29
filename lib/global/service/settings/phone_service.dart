// lib/global/service/settings/phone_service.dart

import 'package:flutter/foundation.dart';
import '../../constant/api_constant.dart';
import '../../model/settings/phone_model.dart';
import '../api_services.dart';

class PhoneService {
  // Get all phones
  static Future<List<PhoneModel>> getPhones() async {
    try {
      final response = await ApiService.getRequest(ApiConstants.studentPhones);
      if (response != null && response is List) {
        return response.map((json) => PhoneModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error fetching phones: $e');
      return [];
    }
  }

  // Update phone by ID using PATCH
  static Future<bool> updatePhone(String phoneId, PhoneModel phone) async {
    try {
      await ApiService.patchRequest(
        ApiConstants.studentPhoneById(phoneId),
        body: phone.toJson(),
      );
      return true;
    } catch (e) {
      debugPrint('Error updating phone: $e');
      return false;
    }
  }
}
