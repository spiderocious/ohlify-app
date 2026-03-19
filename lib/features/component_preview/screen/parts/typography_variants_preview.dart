import 'package:flutter/material.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text.dart';

class TypographyVariantsPreview extends StatelessWidget {
  const TypographyVariantsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('title', const AppText('The quick brown fox', variant: AppTextVariant.title, align: TextAlign.start)),
        _row('header', const AppText('Section Header', variant: AppTextVariant.header, align: TextAlign.start)),
        _row('bodyTitle', const AppText('Body Title Text', variant: AppTextVariant.bodyTitle, align: TextAlign.start)),
        _row('medium', const AppText('Medium weight text', variant: AppTextVariant.medium, align: TextAlign.start)),
        _row('subheader', const AppText('Subheader text here', variant: AppTextVariant.subheader, align: TextAlign.start)),
        _row('subtitle', const AppText('A subtitle supporting line', variant: AppTextVariant.subtitle, align: TextAlign.start)),
        _row('body', const AppText('Body copy — regular 14px line height 20px', variant: AppTextVariant.body, align: TextAlign.start)),
        _row('label', const AppText('Label / caption text 12px', variant: AppTextVariant.label, align: TextAlign.start)),
        const SizedBox(height: 24),
        const Text('Color overrides', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textMuted, letterSpacing: 0.6)),
        const SizedBox(height: 12),
        const AppText('Deep blue override', variant: AppTextVariant.body, color: AppColors.textDeepBlue, align: TextAlign.start),
        const SizedBox(height: 6),
        const AppText('Forest green override', variant: AppTextVariant.body, color: AppColors.textForest, align: TextAlign.start),
        const SizedBox(height: 6),
        const AppText('Amber override', variant: AppTextVariant.body, color: AppColors.textAmber, align: TextAlign.start),
        const SizedBox(height: 6),
        const AppText('Navy override', variant: AppTextVariant.body, color: AppColors.textNavy, align: TextAlign.start),
        const SizedBox(height: 6),
        const AppText('Weight override (w700)', variant: AppTextVariant.body, weight: FontWeight.w700, align: TextAlign.start),
      ],
    );
  }

  Widget _row(String name, Widget widget) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(fontSize: 10, color: AppColors.textSlate, fontWeight: FontWeight.w500, letterSpacing: 0.4)),
          const SizedBox(height: 2),
          widget,
        ],
      ),
    );
  }
}
