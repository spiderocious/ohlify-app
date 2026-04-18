import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class DetailsModalContent extends StatelessWidget {
  const DetailsModalContent({super.key, required this.details});

  final String details;

  @override
  Widget build(BuildContext context) {
    return AppText(
      details,
      variant: AppTextVariant.body,
      color: AppColors.textJet,
      align: TextAlign.start,
    );
  }
}
