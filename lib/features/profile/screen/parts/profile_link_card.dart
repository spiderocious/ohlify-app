import 'package:flutter/material.dart';

import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class ProfileLinkCard extends StatelessWidget {
  const ProfileLinkCard({
    super.key,
    required this.profileUrl,
    required this.onCopy,
  });

  final String profileUrl;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    AppIcons.chat,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'Your personal Ohlify link',
                        variant: AppTextVariant.body,
                        color: AppColors.textJet,
                        weight: FontWeight.w600,
                        align: TextAlign.start,
                      ),
                      SizedBox(height: 2),
                      AppText(
                        'Share your link with your community',
                        variant: AppTextVariant.label,
                        color: AppColors.textMuted,
                        align: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: AppColors.border),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                const Icon(AppIcons.copyLink, size: 16, color: AppColors.textMuted),
                const SizedBox(width: 8),
                Expanded(
                  child: AppText(
                    profileUrl,
                    variant: AppTextVariant.body,
                    color: AppColors.textMuted,
                    align: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                AppButton(
                  label: 'Copy link',
                  variant: AppButtonVariant.outline,
                  onPressed: onCopy,
                  height: 36,
                  radius: 100,
                  textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
