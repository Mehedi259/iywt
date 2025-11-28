import 'package:flutter/material.dart';
import '../../../../core/custom_assets/assets.gen.dart';

class RequirementsTab extends StatelessWidget {
  final double horizontalPadding;

  const RequirementsTab({
    super.key,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFDFDFD),
              border: Border.all(color: const Color(0xFFC7C7C7), width: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F7),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                  child: Row(
                    children: [
                      Image.asset(Assets.images.requirements.path, width: 20, height: 20),
                      const SizedBox(width: 8),
                      const Text('Requirements', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                _buildRequirementItem('Valid at least six months beyond your intended return (Jan. 2026).'),
                _buildRequirementItem('Must be signed by the named holder (or Legal Guardian if under 16) in blue or black ink.'),
                _buildRequirementItem('Must have at least one blank page in Visa section.'),
                _buildRequirementItem('Submit one clear color copy of signature/information pages.'),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFC7C7C7))),
      ),
      child: Text(text, style: const TextStyle(fontSize: 13, height: 1.4)),
    );
  }
}