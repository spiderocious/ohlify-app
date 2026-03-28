import 'package:flutter/material.dart';

import 'package:ohlify/ui/icons/app_svgs.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_svg/app_svg.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({
    super.key,
    this.notificationCount = 0,
    this.onCopyLink,
    this.onNotification,
  });

  final int notificationCount;
  final VoidCallback? onCopyLink;
  final VoidCallback? onNotification;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: AppColors.surface,
      child: Row(
        children: [
          // SVG logo — tinted null so the original two-colour design shows
          const AppSvg(AppSvgs.logo, height: 28),

          const Spacer(),

          // Copy link button
          GestureDetector(
            onTap: onCopyLink,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.textWhite,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppSvg(AppSvgs.copy, size: 16),
                  SizedBox(width: 6),
                  Text(
                    'Copy link',
                    style: TextStyle(
                      fontFamily: 'MonaSans',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Notification bell
          GestureDetector(
            onTap: onNotification,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Center(
                    child: Icon(
                      Icons.notifications_rounded,
                      size: 20,
                      color: AppColors.primary,
                    ),
                  ),
                  if (notificationCount > 0)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            notificationCount > 9
                                ? '9+'
                                : '$notificationCount',
                            style: const TextStyle(
                              fontFamily: 'MonaSans',
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
