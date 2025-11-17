import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,  // fixed height instead of 70.h
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context: context,
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Home',
            index: 0,
            route: '/home',
          ),
          _buildNavItem(
            context: context,
            icon: Icons.airplane_ticket_outlined,
            activeIcon: Icons.airplane_ticket,
            label: 'Destination',
            index: 1,
            route: '/destination',
          ),
          _buildNavItem(
            context: context,
            icon: Icons.description_outlined,
            activeIcon: Icons.description,
            label: 'Documents',
            index: 2,
            route: '/documents',
          ),
          _buildNavItem(
            context: context,
            icon: Icons.message_outlined,
            activeIcon: Icons.message,
            label: 'Messages',
            index: 3,
            route: '/massageScreen',
          ),
          _buildNavItem(
            context: context,
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: 'Profile',
            index: 4,
            route: '/settings',
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    required String route,
  }) {
    final bool isActive = currentIndex == index;

    return InkWell(
      onTap: () {
        if (!isActive) {
          context.go(route);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? const Color(0xFF5B7FBF) : Colors.grey.shade400,
              size: 26,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isActive ? const Color(0xFF5B7FBF) : Colors.grey.shade400,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
