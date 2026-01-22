// lib/features/screens/documents/school_acceptance/school_acceptance_widget/uploads.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../global/controler/documents/documents_controler.dart';


class UploadsTab extends StatelessWidget {
  final double horizontalPadding;

  const UploadsTab({
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
      if (detail == null || detail.documentUploads.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.upload_file_outlined,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              const Text(
                'No uploads yet',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Use the scan or upload button to add documents',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      }

      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Scan Uploads',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ...detail.documentUploads.asMap().entries.map((entry) {
                    final index = entry.key;
                    final upload = entry.value;
                    final isLast = index == detail.documentUploads.length - 1;

                    return Column(
                      children: [
                        _buildUploadCard(
                          date: _formatDate(upload.createdOn),
                          uploadedBy: upload.createdBy,
                          description: upload.description,
                          documentUrl: upload.url,
                        ),
                        if (!isLast) const SizedBox(height: 12),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      );
    });
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  Widget _buildUploadCard({
    required String date,
    required String uploadedBy,
    required String description,
    required String documentUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFDFD),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFC7C7C7),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Uploaded by',
                  style: TextStyle(
                    fontSize: 8,
                    color: Color(0xFFC7C7C7),
                  ),
                ),
                Text(
                  uploadedBy,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF1D1B20),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 8,
                    color: Color(0xFFC7C7C7),
                  ),
                ),
                Text(
                  description.isNotEmpty ? description : 'No description',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF1D1B20),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => _openDocument(documentUrl),
            child: const Text(
              'View scan',
              style: TextStyle(color: Color(0xFF375BA4)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openDocument(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          'Error',
          'Could not open document',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to open document: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}