import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iywt/core/routes/routes.dart';
import '../../../core/routes/route_path.dart';
import '../../../core/custom_assets/assets.gen.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            child: Image(
              image: Assets.images.backIcon.provider(),
              height: 44,
              width: 44
            ),
          ),
          onPressed: () => context.go(RoutePath.documents.addBasePath),
        ),
        title: const Text(
          'Student',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Image(
                  image: Assets.images.alert.provider(),
                  height: 16,
                  width: 16,
                ),
                const SizedBox(width: 4),
                const Text(
                  '1/2',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildDocumentItem(
              title: 'College Certificate',
              description:
              'Get final certificate as soon as your final grades for the term are posted.',
              isComplete: false,
              icon: Assets.images.alert,
            ),
            const SizedBox(height: 16),
            _buildDocumentItem(
              title: 'College Transcript',
              description:
              'Get final transcripts as soon as your final grades for the term are posted.',
              isComplete: true,
              icon: Assets.images.correct,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentItem({
    required String title,
    required String description,
    required bool isComplete,
    required AssetGenImage icon,
  }) {
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
          // TEXT BLOCK
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // STATUS ICON (IMAGE)
          Image(
            image: icon.provider(),
            height: 20,
            width: 20,
          ),


          const SizedBox(width: 6),

          // ------------ ARROW ------------
          Icon(
            Icons.chevron_right,
            size: 26,
            color: Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
