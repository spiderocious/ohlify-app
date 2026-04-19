import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

/// Reusable KYC / setup progress card used by the professional and client
/// onboarding flows. Shows a title, `X of Y steps done`, a percentage, and
/// a linear progress bar.
class KycProgressHeader extends StatelessWidget {
  const KycProgressHeader({
    super.key,
    required this.completed,
    required this.total,
    required this.percent,
    this.title = 'Complete your profile',
  });

  final int completed;
  final int total;
  final int percent;
  final String title;

  double get _ratio => total == 0 ? 0 : completed / total;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      title,
                      variant: AppTextVariant.medium,
                      color: AppColors.textJet,
                      weight: FontWeight.w700,
                      align: TextAlign.start,
                    ),
                    const SizedBox(height: 4),
                    AppText(
                      '$completed of $total steps done',
                      variant: AppTextVariant.body,
                      color: AppColors.textMuted,
                      align: TextAlign.start,
                    ),
                  ],
                ),
              ),
              AppText(
                '$percent%',
                variant: AppTextVariant.header,
                color: AppColors.primary,
                weight: FontWeight.w700,
                align: TextAlign.end,
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
              value: _ratio,
              minHeight: 8,
              backgroundColor: AppColors.surfaceLight,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
