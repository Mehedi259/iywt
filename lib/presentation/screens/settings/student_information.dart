// ============================================
// lib/presentation/screens/settings/student_information.dart
// ============================================

import 'package:flutter/material.dart';
import '../../../core/custom_assets/assets.gen.dart';

class StudentInformationScreen extends StatefulWidget {
  const StudentInformationScreen({super.key});

  @override
  State<StudentInformationScreen> createState() =>
      _StudentInformationScreenState();
}

class _StudentInformationScreenState extends State<StudentInformationScreen> {
  final TextEditingController _preferredNameController =
  TextEditingController(text: 'Kyle Barnes');
  final TextEditingController _dobController =
  TextEditingController(text: '25 JUL 1995');
  final TextEditingController _guardian1Controller =
  TextEditingController(text: 'Bob Smith');
  final TextEditingController _guardian2Controller =
  TextEditingController(text: 'Aleena Smith');

  String _selectedGender = 'Male';
  String _selectedPronoun = 'She / Her';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          child: IconButton(
            icon: Assets.images.backIcon.image(width: 44, height: 44),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'Student Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue.shade200,
                  child: ClipOval(
                    child: Assets.images.profilepicture.image(width: 120, height: 120, fit: BoxFit.cover),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: Assets.images.camera.image(width: 20, height: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            _buildTextField(
              label: 'Preferred Name',
              controller: _preferredNameController,
            ),
            const SizedBox(height: 20),

            _buildTextField(
              label: 'Date of Birth',
              controller: _dobController,
              suffixIcon: Assets.images.dateOfBirthIcon,
              readOnly: true,
            ),
            const SizedBox(height: 20),

            _buildDropdownField(
              label: 'Gender',
              value: _selectedGender,
              items: ['Male', 'Female', 'Non-binary'],
              onChanged: (value) => setState(() => _selectedGender = value!),
            ),
            const SizedBox(height: 20),

            _buildTextField(
              label: 'Parent / Legal Guardian 1',
              controller: _guardian1Controller,
            ),
            const SizedBox(height: 20),

            _buildTextField(
              label: 'Parent / Legal Guardian 2',
              controller: _guardian2Controller,
            ),
            const SizedBox(height: 20),

            _buildDropdownField(
              label: 'Pronouns',
              value: _selectedPronoun,
              items: ['She / Her', 'He / Him', 'They / Them', 'Prefer not to say'],
              onChanged: (value) => setState(() => _selectedPronoun = value!),
            ),
            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  print('Edit Profile clicked');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5B7FBF),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Edit profile',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    AssetGenImage? suffixIcon,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: readOnly,
          decoration: InputDecoration(
            suffixIcon: suffixIcon != null
                ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: suffixIcon.image(width: 20, height: 20),
            )
                : null,
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF5B7FBF)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF5B7FBF)),
            ),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _preferredNameController.dispose();
    _dobController.dispose();
    _guardian1Controller.dispose();
    _guardian2Controller.dispose();
    super.dispose();
  }
}
