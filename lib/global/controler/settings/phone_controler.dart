// lib/global/controller/settings/phone_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/settings/phone_model.dart';
import '../../service/settings/phone_service.dart';

class PhoneController extends GetxController {
  final isLoading = false.obs;
  final phones = <PhoneModel>[].obs;

  final phoneController = TextEditingController();
  final selectedType = 'Student Cell'.obs;

  String? currentPhoneId;

  @override
  void onInit() {
    super.onInit();
    loadPhones();
  }

  // Load all phones
  Future<void> loadPhones() async {
    try {
      isLoading.value = true;
      final data = await PhoneService.getPhones();
      phones.value = data;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load phone numbers');
    } finally {
      isLoading.value = false;
    }
  }

  // Populate fields for editing
  void populateFields(PhoneModel phone) {
    currentPhoneId = phone.phoneId;
    phoneController.text = phone.phone ?? '';
    selectedType.value = phone.phoneType ?? 'Student Cell';
  }

  // Clear form fields
  void clearFields() {
    currentPhoneId = null;
    phoneController.clear();
    selectedType.value = 'Student Cell';
  }

  // Save or update phone
  Future<void> savePhone() async {
    if (currentPhoneId == null) {
      Get.snackbar('Error', 'Phone ID not found');
      return;
    }

    try {
      isLoading.value = true;

      final phone = PhoneModel(
        phone: phoneController.text,
        phoneType: selectedType.value,
        phoneId: currentPhoneId,
      );

      final success = await PhoneService.updatePhone(currentPhoneId!, phone);

      if (success) {
        Get.snackbar('Success', 'Phone number saved successfully',
            snackPosition: SnackPosition.BOTTOM);
        Get.back();
        await loadPhones();
      } else {
        Get.snackbar('Error', 'Failed to save phone number');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}