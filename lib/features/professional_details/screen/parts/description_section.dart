import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          'About',
          variant: AppTextVariant.header,
          color: AppColors.textJet,
          weight: FontWeight.w700,
          align: TextAlign.start,
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(16),
          ),
          child: AppText(
            description,
            variant: AppTextVariant.body,
            color: AppColors.textJet,
            align: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
