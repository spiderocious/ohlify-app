import 'package:flutter/material.dart';

import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/icons/app_svgs.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_svg/app_svg.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class ProfessionalRatesList extends StatelessWidget {
  const ProfessionalRatesList({super.key, required this.rates});

  final List<ProfessionalRate> rates;

  @override
  Widget build(BuildContext context) {
    final audio = rates.where((r) => r.callType == CallType.audio).toList();
    final video = rates.where((r) => r.callType == CallType.video).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (audio.isNotEmpty) ...[
          _RateGroup(
            title: 'Audio call',
            rates: audio,
            backgroundColor: const Color(0xFFECFDF3),
          ),
          const SizedBox(height: 16),
        ],
        if (video.isNotEmpty)
          _RateGroup(
            title: 'Video call',
            rates: video,
            backgroundColor: AppColors.surfaceLight,
          ),
      ],
    );
  }
}

class _RateGroup extends StatelessWidget {
  const _RateGroup({
    required this.title,
    required this.rates,
    required this.backgroundColor,
  });

  final String title;
  final List<ProfessionalRate> rates;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          title,
          variant: AppTextVariant.body,
          color: AppColors.textMuted,
          align: TextAlign.start,
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              for (int i = 0; i < rates.length; i++) ...[
                if (i > 0)
                  const Divider(height: 1, thickness: 1, color: AppColors.border),
                _RateRow(rate: rates[i]),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _RateRow extends StatelessWidget {
  const _RateRow({required this.rate});

  final ProfessionalRate rate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          const AppSvg(AppSvgs.stopwatch, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: AppText(
              '${rate.durationMinutes} minutes',
              variant: AppTextVariant.body,
              color: AppColors.textJet,
              weight: FontWeight.w500,
              align: TextAlign.start,
            ),
          ),
          AppText(
            rate.price,
            variant: AppTextVariant.body,
            color: AppColors.textForest,
            weight: FontWeight.w700,
            align: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
