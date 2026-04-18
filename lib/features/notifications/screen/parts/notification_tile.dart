import 'package:flutter/material.dart';

import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
  });

  final AppNotification notification;
  final VoidCallback onTap;

  ({Color bg, Color icon, IconData glyph}) get _visual => switch (notification.kind) {
        AppNotificationKind.missedCall => (
          bg: const Color(0xFFE0F2FE),
          icon: const Color(0xFF0284C7),
          glyph: Icons.notifications_active_rounded,
        ),
        AppNotificationKind.upcomingCall => (
          bg: const Color(0xFFFFEDD5),
          icon: const Color(0xFFEA580C),
          glyph: Icons.notifications_rounded,
        ),
        AppNotificationKind.paymentReceived => (
          bg: const Color(0xFFE0F2FE),
          icon: const Color(0xFF0284C7),
          glyph: Icons.notifications_active_rounded,
        ),
        AppNotificationKind.system => (
          bg: AppColors.surfaceDark,
          icon: AppColors.primary,
          glyph: Icons.notifications_rounded,
        ),
      };

  @override
  Widget build(BuildContext context) {
    final v = _visual;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: v.bg, shape: BoxShape.circle),
                  child: Icon(v.glyph, size: 20, color: v.icon),
                ),
                if (!notification.read)
                  Positioned(
                    top: -1,
                    right: -1,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColors.danger,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.background, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    notification.title,
                    variant: AppTextVariant.body,
                    color: AppColors.textJet,
                    weight: FontWeight.w700,
                    align: TextAlign.start,
                  ),
                  const SizedBox(height: 4),
                  AppText(
                    notification.message,
                    variant: AppTextVariant.body,
                    color: AppColors.textMuted,
                    align: TextAlign.start,
                  ),
                  const SizedBox(height: 8),
                  AppText(
                    notification.timeLabel,
                    variant: AppTextVariant.bodyNormal,
                    color: AppColors.textSlate,
                    align: TextAlign.start,
                  ),
                ],
              ),
            ),
            if (notification.navigatesToDetail) ...[
              const SizedBox(width: 8),
              const Icon(
                AppIcons.chevronRight,
                size: 20,
                color: AppColors.textSlate,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
