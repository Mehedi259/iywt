import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/custom_assets/assets.gen.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
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
            activeIcon: Assets.images.homeActive.path,
            inactiveIcon: Assets.images.homeInactive.path,
            index: 0,
            route: '/home',
          ),
          _buildNavItem(
            context: context,
            activeIcon: Assets.images.destinationActive.path,
            inactiveIcon: Assets.images.destinationInactive.path,
            index: 1,
            route: '/destination',
          ),
          _buildNavItem(
            context: context,
            activeIcon: Assets.images.documentsActive.path,
            inactiveIcon: Assets.images.documentsInactive.path,
            index: 2,
            route: '/documents',
          ),
          _buildNavItem(
            context: context,
            activeIcon: Assets.images.massageActive.path,
            inactiveIcon: Assets.images.massageInactive.path,
            index: 3,
            route: '/massageScreen',
          ),
          _buildNavItem(
            context: context,
            activeIcon: Assets.images.profileActive.path,
            inactiveIcon: Assets.images.profileInactive.path,
            index: 4,
            route: '/settings',
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required String activeIcon,
    required String inactiveIcon,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Image.asset(
          isActive ? activeIcon : inactiveIcon,
          width: 28,
          height: 28,
        ),
      ),
    );
  }
}
