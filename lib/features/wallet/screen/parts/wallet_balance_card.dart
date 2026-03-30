import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({
    super.key,
    required this.balance,
    required this.onWithdraw,
  });

  final String balance;
  final VoidCallback onWithdraw;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText(
                  'Wallet balance',
                  variant: AppTextVariant.body,
                  color: AppColors.textWhite,
                  align: TextAlign.start,
                ),
                const SizedBox(height: 6),
                AppText(
                  balance,
                  variant: AppTextVariant.header,
                  color: AppColors.textWhite,
                  align: TextAlign.start,
                  weight: FontWeight.w700,
                ),
                const SizedBox(height: 20),
                _WithdrawButton(onPressed: onWithdraw),
              ],
            ),
          ),
          const SizedBox(width: 16),
          const _DecorativeGrid(),
        ],
      ),
    );
  }
}

class _WithdrawButton extends StatelessWidget {
  const _WithdrawButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(100),
        ),
        child: const AppText(
          'Withdraw funds',
          variant: AppTextVariant.body,
          color: AppColors.primary,
          weight: FontWeight.w600,
          align: TextAlign.center,
        ),
      ),
    );
  }
}

class _DecorativeGrid extends StatelessWidget {
  const _DecorativeGrid();

  @override
  Widget build(BuildContext context) {
    const cellColor = Color(0xFF5A50E8);
    const checkColor = Color(0xFF7B73ED);

    return SizedBox(
      width: 88,
      height: 88,
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
        children: [
          _GridCell(color: cellColor),
          _GridCell(color: checkColor, hasCheck: true),
          _GridCell(color: checkColor, hasCheck: true),
          _GridCell(color: cellColor),
        ],
      ),
    );
  }
}

class _GridCell extends StatelessWidget {
  const _GridCell({required this.color, this.hasCheck = false});

  final Color color;
  final bool hasCheck;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: hasCheck
          ? const Icon(Icons.check, color: Colors.white, size: 16)
          : null,
    );
  }
}
