import 'package:flutter/material.dart';

import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class CallHistorySection extends StatelessWidget {
  const CallHistorySection({super.key, required this.history});

  final List<CompletedCallItem> history;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          'Call history',
          variant: AppTextVariant.header,
          color: AppColors.textJet,
          weight: FontWeight.w700,
          align: TextAlign.start,
        ),
        const SizedBox(height: 10),
        if (history.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const AppText(
              'No previous calls with this professional.',
              variant: AppTextVariant.body,
              color: AppColors.textMuted,
              align: TextAlign.center,
            ),
          )
        else
          Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                for (int i = 0; i < history.length; i++) ...[
                  if (i > 0)
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.border,
                    ),
                  _HistoryRow(call: history[i]),
                ],
              ],
            ),
          ),
      ],
    );
  }
}

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({required this.call});

  final CompletedCallItem call;

  @override
  Widget build(BuildContext context) {
    final icon = call.callType == CallType.video
        ? AppIcons.video
        : AppIcons.phone;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppColors.surfaceLight,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  call.callType == CallType.video
                      ? 'Video call'
                      : 'Audio call',
                  variant: AppTextVariant.body,
                  color: AppColors.textJet,
                  weight: FontWeight.w600,
                  align: TextAlign.start,
                ),
                const SizedBox(height: 2),
                AppText(
                  '${call.time}  •  ${call.duration}',
                  variant: AppTextVariant.bodyNormal,
                  color: AppColors.textMuted,
                  align: TextAlign.start,
                ),
              ],
            ),
          ),
          AppText(
            call.amount,
            variant: AppTextVariant.body,
            color: AppColors.textJet,
            weight: FontWeight.w600,
            align: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
