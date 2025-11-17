import 'package:flutter/material.dart';
import '../../widgets/custom_navigation/custom_navbar.dart';

enum DocumentStatus { complete, incomplete, warning }

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Documents',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildDocumentCard(
              title: 'Preliminary',
              icon: Icons.description,
              progress: 5,
              total: 5,
              status: DocumentStatus.complete,
            ),
            const SizedBox(height: 16),
            _buildDocumentCard(
              title: 'Student',
              icon: Icons.school,
              progress: 3,
              total: 5,
              status: DocumentStatus.incomplete,
            ),
            const SizedBox(height: 16),
            _buildDocumentCard(
              title: 'Country',
              icon: Icons.flag,
              progress: 2,
              total: 5,
              status: DocumentStatus.warning,
              flagUrl: 'https://flagcdn.com/w40/ro.png',
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 2),
    );
  }

  Widget _buildDocumentCard({
    required String title,
    required IconData icon,
    required int progress,
    required int total,
    required DocumentStatus status,
    String? flagUrl,
  }) {
    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case DocumentStatus.complete:
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case DocumentStatus.incomplete:
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
      case DocumentStatus.warning:
        statusColor = Colors.orange;
        statusIcon = Icons.warning;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: Color(0xFF5B7FBF),
              shape: BoxShape.circle,
            ),
            child: flagUrl != null
                ? ClipOval(
              child: Image.network(
                flagUrl,
                fit: BoxFit.cover,
              ),
            )
                : Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(statusIcon, color: statusColor, size: 28),
              const SizedBox(height: 4),
              Text(
                '$progress/$total',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 24),
        ],
      ),
    );
  }
}
