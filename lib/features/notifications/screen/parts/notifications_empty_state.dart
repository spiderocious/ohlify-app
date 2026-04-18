import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class NotificationsEmptyState extends StatelessWidget {
  const NotificationsEmptyState({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 16,
                  left: 22,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE5E7EB),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  width: 88,
                  height: 88,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5E7EB),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications_rounded,
                    size: 44,
                    color: Color(0xFFB5B9C1),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          AppText(
            message ?? 'No Notifications Yet',
            variant: AppTextVariant.medium,
            color: AppColors.textMuted,
            weight: FontWeight.w500,
            align: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
