import 'package:flutter/material.dart';

import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/professional_rates_list/professional_rates_list.dart';

class RatesSection extends StatelessWidget {
  const RatesSection({super.key, required this.rates});

  final List<ProfessionalRate> rates;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          'Rates',
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
          child: ProfessionalRatesList(rates: rates),
        ),
      ],
    );
  }
}
