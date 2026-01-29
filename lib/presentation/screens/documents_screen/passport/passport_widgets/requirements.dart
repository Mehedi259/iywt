// lib/features/screens/documents/passport/passport_widgets/requirements.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/custom_assets/assets.gen.dart';
import '../../../../../global/controler/documents/documents_controler.dart';


class RequirementsTab extends StatelessWidget {
  final double horizontalPadding;

  const RequirementsTab({
    super.key,
    required this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    final DocumentsController controller = Get.find<DocumentsController>();

    return Obx(() {
      if (controller.isLoadingDetail.value) {
        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF375BA4),
          ),
        );
      }

      final detail = controller.currentDocumentDetail.value;
      if (detail == null || detail.requirements.isEmpty) {
        return const Center(
          child: Text(
            'No requirements available',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        );
      }

      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFDFDFD),
                border: Border.all(
                  color: const Color(0xFFC7C7C7),
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F5F7),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.images.requirements.path,
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Requirements',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...detail.requirements.asMap().entries.map((entry) {
                    final index = entry.key;
                    final requirement = entry.value;
                    final isLast = index == detail.requirements.length - 1;

                    return _buildRequirementItem(
                      requirement,
                      isLast: isLast,
                    );
                  }).toList(),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      );
    });
  }

  Widget _buildRequirementItem(String text, {bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
          bottom: BorderSide(color: Color(0xFFC7C7C7)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFF375BA4),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                height: 1.4,
                color: Color(0xFF1D1B20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}