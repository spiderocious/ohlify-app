import 'package:flutter/material.dart';

import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button.dart';

class ButtonsPreview extends StatelessWidget {
  const ButtonsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel('Solid'),
        const SizedBox(height: 12),
        AppButton(
          label: 'Proceed',
          onPressed: () {},
          expanded: true,
          radius: 100,
        ),
        const SizedBox(height: 10),
        AppButton(
          label: 'Continue',
          onPressed: () {},
          expanded: true,
          radius: 10,
          endIcon: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              AppIcons.chevronRight,
              color: Colors.black87,
              size: 20,
            ),
          ),
        ),
        const SizedBox(height: 10),
        AppButton(
          label: 'Solid with start icon',
          onPressed: () {},
          expanded: true,
          radius: 12,
          startIcon: const Icon(AppIcons.check, color: Colors.white, size: 18),
        ),
        const SizedBox(height: 24),
        const _SectionLabel('Outline'),
        const SizedBox(height: 12),
        AppButton(
          label: 'Cancel',
          onPressed: () {},
          variant: AppButtonVariant.outline,
          expanded: true,
          radius: 100,
        ),
        const SizedBox(height: 10),
        AppButton(
          label: 'Outline with icon',
          onPressed: () {},
          variant: AppButtonVariant.outline,
          expanded: true,
          radius: 12,
          startIcon: const Icon(AppIcons.close, color: AppColors.primary, size: 18),
        ),
        const SizedBox(height: 24),
        const _SectionLabel('Plain'),
        const SizedBox(height: 12),
        AppButton(
          label: 'Skip',
          onPressed: () {},
          variant: AppButtonVariant.plain,
          expanded: true,
          radius: 100,
        ),
        const SizedBox(height: 10),
        // Rating-badge style — plain button wrapping a custom child
        AppButton(
          onPressed: () {},
          variant: AppButtonVariant.plain,
          radius: 100,
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(AppIcons.medal, color: Color(0xFFE07B1A), size: 20),
              SizedBox(width: 6),
              Text(
                '4.9  View reviews',
                style: TextStyle(
                  color: Color(0xFFE07B1A),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const _SectionLabel('Subtle'),
        const SizedBox(height: 12),
        AppButton(
          label: 'Subtle (no border)',
          onPressed: () {},
          variant: AppButtonVariant.subtle,
          expanded: true,
          radius: 100,
        ),
        const SizedBox(height: 10),
        AppButton(
          label: 'Subtle with border',
          onPressed: () {},
          variant: AppButtonVariant.subtle,
          bordered: true,
          expanded: true,
          radius: 100,
        ),
        const SizedBox(height: 10),
        AppButton(
          label: 'Subtle with custom border color',
          onPressed: () {},
          variant: AppButtonVariant.subtle,
          bordered: true,
          borderColor: AppColors.danger,
          expanded: true,
          radius: 12,
          startIcon: const Icon(AppIcons.check, color: AppColors.primary, size: 18),
        ),
        const SizedBox(height: 10),
        const AppButton(
          label: 'Subtle disabled',
          variant: AppButtonVariant.subtle,
          expanded: true,
          radius: 12,
        ),
        const SizedBox(height: 24),
        const _SectionLabel('Border prop on other variants'),
        const SizedBox(height: 12),
        AppButton(
          label: 'Solid with border',
          onPressed: () {},
          bordered: true,
          expanded: true,
          radius: 12,
        ),
        const SizedBox(height: 10),
        AppButton(
          label: 'Solid with custom border color',
          onPressed: () {},
          bordered: true,
          borderColor: AppColors.accent,
          expanded: true,
          radius: 12,
        ),
        const SizedBox(height: 10),
        AppButton(
          label: 'Plain with border',
          onPressed: () {},
          variant: AppButtonVariant.plain,
          bordered: true,
          expanded: true,
          radius: 12,
        ),
        const SizedBox(height: 10),
        AppButton(
          label: 'Outline without border',
          onPressed: () {},
          variant: AppButtonVariant.outline,
          bordered: false,
          expanded: true,
          radius: 12,
        ),
        const SizedBox(height: 10),
        AppButton(
          label: 'Outline with custom border color',
          onPressed: () {},
          variant: AppButtonVariant.outline,
          borderColor: AppColors.danger,
          expanded: true,
          radius: 12,
        ),
        const SizedBox(height: 24),
        const _SectionLabel('Disabled states'),
        const SizedBox(height: 12),
        const AppButton(
          label: 'Disabled solid',
          expanded: true,
          radius: 12,
        ),
        const SizedBox(height: 10),
        const AppButton(
          label: 'Disabled outline',
          variant: AppButtonVariant.outline,
          expanded: true,
          radius: 12,
        ),
        const SizedBox(height: 10),
        AppButton(
          label: 'Loading',
          onPressed: () {},
          expanded: true,
          radius: 12,
          isLoading: true,
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
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
