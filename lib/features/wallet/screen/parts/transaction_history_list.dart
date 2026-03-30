import 'package:flutter/material.dart';

import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class TransactionHistoryList extends StatelessWidget {
  const TransactionHistoryList({super.key, required this.transactions});

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          'Transaction history',
          variant: AppTextVariant.body,
          color: AppColors.textMuted,
          align: TextAlign.start,
        ),
        const SizedBox(height: 8),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: transactions.length,
          separatorBuilder: (_, _) => const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.border,
          ),
          itemBuilder: (_, i) => _TransactionRow(tx: transactions[i]),
        ),
      ],
    );
  }
}

class _TransactionRow extends StatelessWidget {
  const _TransactionRow({required this.tx});

  final Transaction tx;

  IconData get _icon => switch (tx.type) {
    TransactionType.withdrawalToBank   => AppIcons.building,
    TransactionType.paymentAudioCall   => AppIcons.phone,
    TransactionType.scheduledAudioCall => AppIcons.phone,
    TransactionType.paymentVideoCall   => AppIcons.video,
  };

  Color get _amountColor {
    if (tx.isCredit) return AppColors.success;
    if (tx.isDebit) return AppColors.danger;
    return AppColors.textJet;
  }

  String get _statusLabel => switch (tx.status) {
    TransactionStatus.completed => 'Completed',
    TransactionStatus.pending   => 'Pending',
    TransactionStatus.failed    => 'Failed',
  };

  Color get _statusColor => switch (tx.status) {
    TransactionStatus.completed => AppColors.success,
    TransactionStatus.pending   => AppColors.warning,
    TransactionStatus.failed    => AppColors.danger,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          _IconBubble(icon: _icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  tx.title,
                  variant: AppTextVariant.body,
                  color: AppColors.textJet,
                  weight: FontWeight.w600,
                  align: TextAlign.start,
                ),
                const SizedBox(height: 2),
                AppText(
                  tx.datetime,
                  variant: AppTextVariant.label,
                  color: AppColors.textMuted,
                  align: TextAlign.start,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText(
                tx.amount,
                variant: AppTextVariant.body,
                color: _amountColor,
                weight: FontWeight.w600,
                align: TextAlign.end,
              ),
              const SizedBox(height: 2),
              AppText(
                _statusLabel,
                variant: AppTextVariant.label,
                color: _statusColor,
                align: TextAlign.end,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IconBubble extends StatelessWidget {
  const _IconBubble({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 20, color: AppColors.primary), // icon is runtime value, no const
    );
  }
}
