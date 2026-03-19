import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text.dart';

class OnboardingSlideData {
  const OnboardingSlideData({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;
}

class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({super.key, required this.data});

  final OnboardingSlideData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 58),
        // Phone illustration — shared across all slides
        SizedBox(
          height: 340,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Image.asset(
              'assets/common/login-preview.png',
              fit: BoxFit.contain,
              width: 280,
            ),
          ),
        ),
        const SizedBox(height: 32),
        // Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: AppText(
            data.title,
            variant: AppTextVariant.header,
            align: TextAlign.center,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        // Subtitle
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: AppText(
            data.subtitle,
            variant: AppTextVariant.body,
            align: TextAlign.center,
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 120),
      ],
    );
  }
}
