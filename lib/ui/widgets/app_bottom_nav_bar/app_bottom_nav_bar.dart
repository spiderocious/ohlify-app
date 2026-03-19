import 'package:flutter/material.dart';

import 'package:ohlify/ui/icons/app_svgs.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_svg/app_svg.dart';

class AppBottomNavBarItem {
  const AppBottomNavBarItem({
    required this.svgPath,
    required this.label,
  });

  final String svgPath;
  final String label;
}

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<AppBottomNavBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.navBackground,
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 68,
          child: Row(
            children: List.generate(items.length, (i) {
              return Expanded(
                child: _NavItem(
                  item: items[i],
                  isActive: i == currentIndex,
                  onTap: () => onTap(i),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  final AppBottomNavBarItem item;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: isActive
              ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
              : const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSvg(
                item.svgPath,
                size: 22,
                // Active: white; inactive: null keeps the baked-in #64619C
                color: isActive ? Colors.white : null,
              ),
              if (isActive) ...[
                const SizedBox(width: 8),
                Text(
                  item.label,
                  style: const TextStyle(
                    fontFamily: 'MonaSans',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Pre-built items matching the app's 4 main tabs.
const appMainNavItems = [
  AppBottomNavBarItem(svgPath: AppSvgs.navHome,    label: 'Home'),
  AppBottomNavBarItem(svgPath: AppSvgs.navCalls,   label: 'Calls'),
  AppBottomNavBarItem(svgPath: AppSvgs.navWallet,  label: 'Wallet'),
  AppBottomNavBarItem(svgPath: AppSvgs.navProfile, label: 'Profile'),
];
