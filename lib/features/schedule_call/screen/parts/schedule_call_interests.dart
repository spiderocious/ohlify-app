import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_tag/app_tag.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class ScheduleCallInterests extends StatelessWidget {
  const ScheduleCallInterests({super.key, required this.interests});

  final List<String> interests;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            'Interest',
            variant: AppTextVariant.body,
            color: AppColors.textMuted,
            align: TextAlign.start,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: interests
                .map((i) => AppTag(label: i.toUpperCase()))
                .toList(),
          ),
        ],
      ),
    );
  }
}
