// lib/global/service/settings/technical_support_service.dart

import 'package:flutter/foundation.dart';
import '../../constant/api_constant.dart';
import '../../model/settings/tecnical_support_model.dart';
import '../api_services.dart';

class TechnicalSupportService {
  // Submit technical support request
  static Future<bool> submitSupportRequest(TechnicalSupportModel request) async {
    try {
      await ApiService.postRequest(
        ApiConstants.technicalSupport,
        body: request.toJson(),
      );
      return true;
    } catch (e) {
      debugPrint('Error submitting support request: $e');
      return false;
    }
  }
}