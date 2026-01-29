// lib/global/controler/settings/student_information_controler.dart

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/settings/student_information_model.dart';
import '../../service/settings/student_information_service.dart';

class StudentInformationController extends GetxController {
  final isLoading = false.obs;
  final studentInfo = Rxn<StudentInformationModel>();

  final preferredNameController = TextEditingController();
  final dobController = TextEditingController();
  final guardian1Controller = TextEditingController();
  final guardian2Controller = TextEditingController();

  final selectedGender = 'Male'.obs;
  final selectedPronoun = 'He / Him'.obs;

  File? profilePhotoFile;
  Uint8List? webProfilePhoto;
  final profilePhotoUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadStudentInformation();
  }

  // Load student information
  Future<void> loadStudentInformation() async {
    try {
      isLoading.value = true;
      final data = await StudentInformationService.getStudentInformation();
      if (data != null) {
        studentInfo.value = data;
        _populateFields(data);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load student information');
    } finally {
      isLoading.value = false;
    }
  }

  // Populate form fields
  void _populateFields(StudentInformationModel data) {
    preferredNameController.text = data.preferredName ?? '';
    dobController.text = data.dateOfBirth ?? '';
    guardian1Controller.text = data.parentLegalGuardianOneName ?? '';
    guardian2Controller.text = data.parentLegalGuardianTwoName ?? '';
    selectedGender.value = data.gender ?? 'Male';
    selectedPronoun.value = data.pronouns ?? 'He / Him';
    profilePhotoUrl.value = data.profilePhotoUrl ?? '';
  }

  // Pick profile photo
  Future<void> pickProfilePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        webProfilePhoto = await pickedFile.readAsBytes();
      } else {
        profilePhotoFile = File(pickedFile.path);
      }
      profilePhotoUrl.value = pickedFile.path;
    }
  }

  /// Select Date of Birth
  Future<void> selectDateOfBirth(BuildContext context) async {
    // Parse current date if exists
    DateTime initialDate = DateTime(2000);
    if (dobController.text.isNotEmpty) {
      try {
        initialDate = DateTime.parse(dobController.text);
      } catch (e) {
        // If parsing fails, use default
        initialDate = DateTime(2000);
      }
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF5B7FBF),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // Format: YYYY-MM-DD
      dobController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  // Update student information
  Future<void> updateProfile() async {
    try {
      isLoading.value = true;

      final fields = {
        'preferredName': preferredNameController.text,
        'dateOfBirth': dobController.text,
        'gender': selectedGender.value,
        'parentLegalGuardianOneName': guardian1Controller.text,
        'parentLegalGuardianTwoName': guardian2Controller.text,
        'pronouns': selectedPronoun.value,
      };

      final success = await StudentInformationService.updateStudentInformation(
        fields: fields,
        profilePhoto: profilePhotoFile,
        webProfilePhoto: webProfilePhoto,
      );

      if (success) {
        Get.snackbar(
          'Success',
          'Profile updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await loadStudentInformation();
      } else {
        Get.snackbar(
          'Error',
          'Failed to update profile',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    preferredNameController.dispose();
    dobController.dispose();
    guardian1Controller.dispose();
    guardian2Controller.dispose();
    super.onClose();
  }
}