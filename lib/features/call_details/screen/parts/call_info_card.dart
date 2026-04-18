import 'package:flutter/material.dart';

import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class CallInfoCard extends StatelessWidget {
  const CallInfoCard({super.key, required this.call});

  final CallDetail call;

  @override
  Widget build(BuildContext context) {
    final rows = <(IconData, String, String)>[
      (
        call.callType == CallType.video ? AppIcons.video : AppIcons.phone,
        'Call type',
        call.callType == CallType.video ? 'Video call' : 'Audio call',
      ),
      (Icons.calendar_today_outlined, 'Date', call.date),
      (Icons.access_time_rounded, 'Time', call.time),
      (Icons.timer_outlined, 'Duration', call.duration),
      if (call.amount != null)
        (Icons.receipt_long_outlined, 'Amount', call.amount!),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          for (int i = 0; i < rows.length; i++) ...[
            if (i > 0)
              const Divider(height: 20, thickness: 1, color: AppColors.border),
            _InfoRow(
              icon: rows[i].$1,
              label: rows[i].$2,
              value: rows[i].$3,
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textMuted),
        const SizedBox(width: 12),
        Expanded(
          child: AppText(
            label,
            variant: AppTextVariant.body,
            color: AppColors.textMuted,
            align: TextAlign.start,
          ),
        ),
        AppText(
          value,
          variant: AppTextVariant.body,
          color: AppColors.textJet,
          weight: FontWeight.w600,
          align: TextAlign.end,
        ),
      ],
    );
  }
}
