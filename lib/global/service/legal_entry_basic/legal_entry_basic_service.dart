// lib/global/service/legal_entry_basic/legal_entry_basic_service.dart

import 'dart:developer' as developer;
import '../../constant/api_constant.dart';
import '../../model/legal_entry_basic/legal_entry_basic_model.dart';
import '../api_services.dart';

class LegalEntryBasicService {
  /// Get Legal Entry Basics Data
  static Future<Map<String, dynamic>> getLegalEntryBasics() async {
    try {
      developer.log('📋 Fetching legal entry basics', name: 'LegalEntryBasicService');

      final response = await ApiService.getRequest(
        ApiConstants.legalEntryBasics,
      );

      developer.log('✅ Legal entry basics fetched successfully', name: 'LegalEntryBasicService');

      if (response != null) {
        final data = LegalEntryBasicModel.fromJson(response);
        return {
          'success': true,
          'data': data,
        };
      } else {
        return {
          'success': false,
          'error': 'No data received',
        };
      }
    } catch (e) {
      developer.log('❌ Legal entry basics fetch failed: $e', name: 'LegalEntryBasicService');
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }
}
