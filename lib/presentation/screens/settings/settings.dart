// lib/presentation/screens/settings/settings.dart

import 'package:flutter/material.dart';
import '../../widgets/custom_navigation/custom_navbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Settings',
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

      body: Column(
        children: [
          const SizedBox(height: 24),

          // ---------------- PROFILE SECTION ----------------
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
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
                const CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, size: 36, color: Colors.white),
                ),
                const SizedBox(width: 16),
                const Text(
                  'User Name Placeholder',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ---------------- OPTIONS ----------------
          _buildSettingOption(
            context: context,
            icon: Icons.person_outline,
            title: 'My Information',
            onTap: () {
              print("My Information Clicked");
            },
          ),

          _buildSettingOption(
            context: context,
            icon: Icons.lock_outline,
            title: 'Change Password',
            onTap: () {
              print("Change Password Clicked");
            },
          ),

          Container(
            height: 8,
            color: Colors.grey.shade100,
          ),

          _buildSettingOption(
            context: context,
            icon: Icons.support_agent,
            title: 'Technical Support',
            onTap: () {
              print("Technical Support Clicked");
            },
          ),

          _buildSettingOption(
            context: context,
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            onTap: () {
              print("Privacy Policy Clicked");
            },
          ),

          const Spacer(),

          // ---------------- LOGOUT BUTTON ----------------
          Padding(
            padding: const EdgeInsets.all(16),
            child: OutlinedButton(
              onPressed: () {
                _showLogoutDialog(context);
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side: const BorderSide(color: Color(0xFF5B7FBF), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5B7FBF),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),

      bottomNavigationBar: const CustomNavBar(currentIndex: 4),
    );
  }

  // ---------------- OPTION TILE ----------------
  Widget _buildSettingOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade100),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24, color: Colors.black87),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- LOGOUT DIALOG ----------------
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Logout',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                print("Logout Clicked");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5B7FBF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
