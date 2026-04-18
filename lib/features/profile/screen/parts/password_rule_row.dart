import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class PasswordRuleRow extends StatelessWidget {
  const PasswordRuleRow({
    super.key,
    required this.label,
    required this.satisfied,
  });

  final String label;
  final bool satisfied;

  @override
  Widget build(BuildContext context) {
    final color = satisfied ? AppColors.success : AppColors.textMuted;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: satisfied
                ? AppColors.success.withValues(alpha: 0.15)
                : AppColors.surfaceLight,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check, size: 12, color: color),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: AppText(
            label,
            variant: AppTextVariant.bodyNormal,
            color: color,
            align: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
