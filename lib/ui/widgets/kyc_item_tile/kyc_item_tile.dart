import 'package:flutter/material.dart';

import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

/// Reusable setup row — icon tile, title, subtitle/summary, completion badge,
/// and chevron. Features pass their own title/subtitle/icon so this widget
/// stays decoupled from any KYC enum.
class KycItemTile extends StatelessWidget {
  const KycItemTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.completed,
    required this.onTap,
  });

  final IconData icon;
  final String title;

  /// Short description. Features typically pass the filled value (e.g. the
  /// current occupation) when completed, and a hint sentence otherwise.
  final String subtitle;

  final bool completed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, size: 20, color: AppColors.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title,
                    variant: AppTextVariant.body,
                    color: AppColors.textJet,
                    weight: FontWeight.w600,
                    align: TextAlign.start,
                  ),
                  const SizedBox(height: 2),
                  AppText(
                    subtitle,
                    variant: AppTextVariant.bodyNormal,
                    color: AppColors.textMuted,
                    align: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            _Status(completed: completed),
            const SizedBox(width: 6),
            const Icon(
              AppIcons.chevronRight,
              size: 20,
              color: AppColors.textSlate,
            ),
          ],
        ),
      ),
    );
  }
}

class _Status extends StatelessWidget {
  const _Status({required this.completed});

  final bool completed;

  @override
  Widget build(BuildContext context) {
    if (completed) {
      return Container(
        width: 26,
        height: 26,
        decoration: const BoxDecoration(
          color: AppColors.success,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check_rounded, size: 16, color: Colors.white),
      );
    }
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      child: const Icon(
        Icons.schedule_rounded,
        size: 14,
        color: AppColors.textMuted,
      ),
    );
  }
}
