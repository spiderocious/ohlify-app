import 'package:flutter/material.dart';

import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_tag/app_tag.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

/// Base row used on the Personal Information screen. [subtitle] renders as
/// a single ellipsised line (matches email / phone / occupation).
class PersonalInfoRow extends StatelessWidget {
  const PersonalInfoRow({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _RowShell(
      icon: icon,
      iconColor: iconColor,
      title: title,
      onTap: onTap,
      subtitle: AppText(
        subtitle,
        variant: AppTextVariant.bodyNormal,
        color: AppColors.textMuted,
        align: TextAlign.start,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

/// Row variant that shows a full, wrapping description (no ellipsis).
class PersonalInfoDescriptionRow extends StatelessWidget {
  const PersonalInfoDescriptionRow({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _RowShell(
      icon: icon,
      iconColor: iconColor,
      title: title,
      onTap: onTap,
      subtitle: AppText(
        description,
        variant: AppTextVariant.bodyNormal,
        color: AppColors.textMuted,
        align: TextAlign.start,
      ),
    );
  }
}

/// Row variant that renders the interests list as a Wrap of chip tags.
class PersonalInfoInterestsRow extends StatelessWidget {
  const PersonalInfoInterestsRow({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.interests,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final List<String> interests;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _RowShell(
      icon: icon,
      iconColor: iconColor,
      title: title,
      onTap: onTap,
      subtitle: interests.isEmpty
          ? const AppText(
              'Not set yet',
              variant: AppTextVariant.bodyNormal,
              color: AppColors.textMuted,
              align: TextAlign.start,
            )
          : Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final v in interests)
                  AppTag(
                    label: v.toUpperCase(),
                    variant: AppTagVariant.outline,
                    size: AppTagSize.small,
                  ),
              ],
            ),
    );
  }
}

class _RowShell extends StatelessWidget {
  const _RowShell({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 22, color: iconColor),
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
                    weight: FontWeight.w700,
                    align: TextAlign.start,
                  ),
                  const SizedBox(height: 6),
                  subtitle,
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(
                AppIcons.chevronRight,
                size: 20,
                color: AppColors.textSlate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
