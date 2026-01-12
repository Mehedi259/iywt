import 'package:flutter/material.dart';

import '../../../../../core/custom_assets/assets.gen.dart';


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
                _buildRequirementItem('College Transcript must be original and officially issued by the institution.'),
                _buildRequirementItem('If required, the Transcript should be verified or attested by the appropriate authority.'),
                _buildRequirementItem('The submitted college Transcript copy must be clear and readable.'),
                _buildRequirementItem('Submit one clean color copy of the college Transcript for verification.'),

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