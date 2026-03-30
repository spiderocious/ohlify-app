import 'package:flutter/material.dart';

import 'package:ohlify/features/wallet/screen/parts/transaction_history_list.dart';
import 'package:ohlify/features/wallet/screen/parts/wallet_balance_card.dart';
import 'package:ohlify/features/wallet/screen/parts/wallet_stats_row.dart';
import 'package:ohlify/shared/services/services.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final balance = MockService.getWalletBalance();
    final stats = MockService.getWalletStats();
    final transactions = MockService.getTransactions();

    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              const AppText(
                'Wallet',
                variant: AppTextVariant.title,
                color: AppColors.textJet,
                align: TextAlign.start,
                weight: FontWeight.w800,
              ),
              const SizedBox(height: 20),
              WalletBalanceCard(
                balance: balance,
                onWithdraw: () {},
              ),
              const SizedBox(height: 16),
              WalletStatsRow(stats: stats),
              const SizedBox(height: 24),
              TransactionHistoryList(transactions: transactions),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
