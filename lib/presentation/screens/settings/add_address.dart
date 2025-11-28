
// ============================================
// lib/presentation/screens/settings/add_address.dart
// ============================================

import 'package:flutter/material.dart';

import '../../../core/custom_assets/assets.gen.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final TextEditingController _addressController = TextEditingController(text: '123 Main St');
  final TextEditingController _cityController = TextEditingController(text: 'Town');
  final TextEditingController _stateController = TextEditingController(text: 'OR');
  final TextEditingController _zipController = TextEditingController(text: '12345');

  String _selectedType = 'Residence';
  String _selectedCountry = 'USA';

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
          'Address',
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
            _buildDropdownField(
              label: 'Type',
              value: _selectedType,
              items: ['Residence', 'Mailing'],
              onChanged: (value) => setState(() => _selectedType = value!),
            ),
            const SizedBox(height: 20),

            _buildTextField(label: 'Address', controller: _addressController),
            const SizedBox(height: 20),

            _buildTextField(label: 'City', controller: _cityController),
            const SizedBox(height: 20),

            _buildTextField(label: 'State / Province', controller: _stateController),
            const SizedBox(height: 20),

            _buildTextField(label: 'Zip / Postal Code', controller: _zipController),
            const SizedBox(height: 20),

            _buildDropdownField(
              label: 'Country',
              value: _selectedCountry,
              items: ['USA', 'Canada', 'UK', 'Other'],
              onChanged: (value) => setState(() => _selectedCountry = value!),
            ),
            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  print('Save clicked');
                  Navigator.pop(context);
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
                  'Save',
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
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey.shade400)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
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
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey.shade400)),
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
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    super.dispose();
  }
}