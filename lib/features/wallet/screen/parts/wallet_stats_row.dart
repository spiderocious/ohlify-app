import 'package:flutter/material.dart';

import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/icons/app_svgs.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_svg/app_svg.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class WalletStatsRow extends StatelessWidget {
  const WalletStatsRow({super.key, required this.stats});

  final WalletStats stats;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: AppSvgs.weekIcon,
            label: 'This week',
            value: '${stats.thisWeek}',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: AppSvgs.monthIcon,
            label: 'This month',
            value: '${stats.thisMonth}',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: AppSvgs.totalCallsIcon,
            label: 'Total calls',
            value: '${stats.totalCalls}',
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final String icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSvg(icon, size: 32),
          const SizedBox(height: 12),
          AppText(
            label,
            variant: AppTextVariant.label,
            color: AppColors.textMuted,
            align: TextAlign.start,
          ),
          const SizedBox(height: 4),
          AppText(
            value,
            variant: AppTextVariant.medium,
            color: AppColors.textJet,
            align: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
