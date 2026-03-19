import 'package:flutter/material.dart';

import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_icon_button.dart';

class IconButtonsPreview extends StatelessWidget {
  const IconButtonsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Filled circle'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            // Primary purple — video call
            AppIconButton(
              icon: const Icon(AppIcons.video, color: Colors.white),
              onPressed: () {},
            ),
            // Primary purple — voice call
            AppIconButton(
              icon: const Icon(AppIcons.phone, color: Colors.white),
              onPressed: () {},
            ),
            // Danger red — incoming call
            AppIconButton(
              icon: const Icon(AppIcons.phone, color: Colors.white),
              backgroundColor: AppColors.danger,
              onPressed: () {},
            ),
            // Dark — chat / message
            AppIconButton(
              icon: const Icon(AppIcons.chat, color: Colors.white),
              backgroundColor: const Color(0xFF2C2C2E),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 24),
        _sectionLabel('Outline circle'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            // Red outline — delete
            AppIconButton(
              icon: const Icon(AppIcons.delete, color: AppColors.danger),
              variant: AppIconButtonVariant.outline,
              borderColor: AppColors.danger,
              size: 72,
              onPressed: () {},
            ),
            // Primary outline — close
            AppIconButton(
              icon: const Icon(AppIcons.close, color: AppColors.primary),
              variant: AppIconButtonVariant.outline,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 24),
        _sectionLabel('Filled squircle'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            // Soft red squircle — delete action
            AppIconButton(
              icon: const Icon(
                AppIcons.delete,
                color: Color(0xFF8B0000),
              ),
              shape: AppIconButtonShape.squircle,
              backgroundColor: const Color(0xFFFDECEA),
              squircleRadius: 18,
              size: 64,
              onPressed: () {},
            ),
            // Primary squircle
            AppIconButton(
              icon: const Icon(AppIcons.add, color: Colors.white),
              shape: AppIconButtonShape.squircle,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 24),
        _sectionLabel('Ghost (callico bg)'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            AppIconButton(
              icon: const Icon(AppIcons.settings, color: AppColors.tertiary),
              variant: AppIconButtonVariant.ghost,
              onPressed: () {},
            ),
            AppIconButton(
              icon: const Icon(AppIcons.search, color: AppColors.tertiary),
              variant: AppIconButtonVariant.ghost,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 24),
        _sectionLabel('Disabled'),
        const SizedBox(height: 12),
        const Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            AppIconButton(
              icon: Icon(AppIcons.phone, color: Colors.white),
            ),
            AppIconButton(
              icon: Icon(AppIcons.delete, color: AppColors.danger),
              variant: AppIconButtonVariant.outline,
              borderColor: AppColors.danger,
            ),
          ],
        ),
      ],
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textMuted,
        letterSpacing: 0.6,
      ),
    );
  }
}
