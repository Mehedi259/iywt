
// lib/global/controler/home/home_controler.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;
import '../../model/home/home_model.dart';
import '../../service/home/home_service.dart';

class HomeController extends GetxController {
  // Observable variables
  final isLoading = false.obs;
  final Rx<DashboardModel?> dashboardData = Rx<DashboardModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchDashboard();
  }

  /// Fetch Dashboard Data
  Future<void> fetchDashboard() async {
    try {
      isLoading.value = true;

      developer.log('🔄 Fetching dashboard data', name: 'HomeController');

      final result = await HomeService.getDashboard();

      if (result['success'] == true) {
        dashboardData.value = result['data'] as DashboardModel;
        developer.log('✅ Dashboard loaded successfully', name: 'HomeController');
      } else {
        developer.log('❌ Dashboard fetch failed: ${result['error']}', name: 'HomeController');
      }
    } catch (e) {
      developer.log('❌ Dashboard error: $e', name: 'HomeController');
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh Dashboard
  Future<void> refreshDashboard() async {
    await fetchDashboard();
  }

  /// Get greeting based on time
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning!';
    } else if (hour < 17) {
      return 'Good Afternoon!';
    } else {
      return 'Good Evening!';
    }
  }
}