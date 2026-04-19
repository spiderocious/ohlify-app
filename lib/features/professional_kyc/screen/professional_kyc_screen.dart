import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:ohlify/features/professional_kyc/providers/professional_kyc_notifier.dart';
import 'package:ohlify/features/professional_kyc/screen/parts/kyc_items_list.dart';
import 'package:ohlify/features/professional_kyc/types/kyc_item.dart';
import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_icon_button/app_icon_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/kyc_progress_header/kyc_progress_header.dart';

class ProfessionalKycScreen extends StatelessWidget {
  const ProfessionalKycScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ProfessionalKycNotifier>();
    final allDone = notifier.completedCount == KycItem.values.length;

    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  AppIconButton(
                    icon: const Icon(AppIcons.back, color: AppColors.textJet),
                    variant: AppIconButtonVariant.ghost,
                    backgroundColor: AppColors.background,
                    size: 44,
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(width: 12),
                  const AppText(
                    'Become a Professional',
                    variant: AppTextVariant.header,
                    color: AppColors.textJet,
                    weight: FontWeight.w700,
                    align: TextAlign.start,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    KycProgressHeader(
                      completed: notifier.completedCount,
                      total: KycItem.values.length,
                      percent: notifier.completionPercent,
                    ),
                    const SizedBox(height: 20),
                    const AppText(
                      'Setup steps',
                      variant: AppTextVariant.body,
                      color: AppColors.textMuted,
                      align: TextAlign.start,
                    ),
                    const SizedBox(height: 10),
                    const KycItemsList(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: AppButton(
                label: 'Go to home',
                expanded: true,
                radius: 100,
                isDisabled: !allDone,
                onPressed:
                    !allDone ? null : () => context.go(AppRoutes.home),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
