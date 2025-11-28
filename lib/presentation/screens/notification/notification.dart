// ============================================
// lib/presentation/screens/notifications/notifications_screen.dart
// ============================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iywt/core/routes/routes.dart';
import '../../../core/custom_assets/assets.gen.dart';
import '../../../core/routes/route_path.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FA),
        elevation: 0,
        leading: IconButton(
          icon: Assets.images.backIcon.image(width: 44, height: 44),
          onPressed: () => context.go(RoutePath.home.addBasePath),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Today Section
          const Text(
            'Today',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),

          _buildNotificationCard(
            iconAsset: Assets.images.alert,
            message: 'You have a warning in the document. Please check it and make the necessary updates.',
          ),

          const SizedBox(height: 12),

          _buildNotificationCard(
            iconAsset: Assets.images.cross,
            message: 'Documents are damaged. Please re-upload.',
          ),

          const SizedBox(height: 32),

          // Yesterday Section
          const Text(
            'Yesterday',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),

          _buildNotificationCard(
            iconAsset: Assets.images.alert,
            message: 'You have a warning in the document. Please check it and make the necessary updates.',
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    required AssetGenImage iconAsset,
    required String message,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(8),
            child: iconAsset.image(
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}