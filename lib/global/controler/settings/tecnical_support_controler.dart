// lib/global/controller/settings/technical_support_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/settings/tecnical_support_model.dart';
import '../../service/settings/tecnical_support_service.dart';

class TechnicalSupportController extends GetxController {
  final isLoading = false.obs;

  final subjectController = TextEditingController();
  final bodyController = TextEditingController();

  // Submit support request
  Future<void> submitRequest() async {
    if (subjectController.text.isEmpty || bodyController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields');
      return;
    }

    try {
      isLoading.value = true;

      final request = TechnicalSupportModel(
        subject: subjectController.text,
        issue: bodyController.text,
      );

      final success = await TechnicalSupportService.submitSupportRequest(request);

      if (success) {
        Get.snackbar('Success', 'Support request submitted successfully',
            snackPosition: SnackPosition.BOTTOM);
        subjectController.clear();
        bodyController.clear();
        Get.back();
      } else {
        Get.snackbar('Error', 'Failed to submit request');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    subjectController.dispose();
    bodyController.dispose();
    super.onClose();
  }
}
