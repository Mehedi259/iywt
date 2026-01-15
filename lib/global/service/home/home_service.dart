// lib/global/service/home/home_service.dart

import 'dart:developer' as developer;
import '../../constant/api_constant.dart';
import '../../model/home/home_model.dart';
import '../api_services.dart';

class HomeService {
  /// Get Dashboard Data
  static Future<Map<String, dynamic>> getDashboard() async {
    try {
      developer.log('📊 Fetching dashboard data', name: 'HomeService');

      final response = await ApiService.getRequest(
        ApiConstants.dashboard,
      );

      developer.log('✅ Dashboard data fetched successfully', name: 'HomeService');

      if (response != null) {
        final dashboardData = DashboardModel.fromJson(response);
        return {
          'success': true,
          'data': dashboardData,
        };
      } else {
        return {
          'success': false,
          'error': 'No data received',
        };
      }
    } catch (e) {
      developer.log('❌ Dashboard fetch failed: $e', name: 'HomeService');
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }
}
