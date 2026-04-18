import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:ohlify/features/professional_kyc/providers/professional_kyc_notifier.dart';
import 'package:ohlify/features/professional_kyc/screen/parts/add_rate_modal_content.dart';
import 'package:ohlify/features/professional_kyc/screen/parts/rates_group.dart';
import 'package:ohlify/features/professional_kyc/types/kyc_rate.dart';
import 'package:ohlify/shared/notifiers/modal_notifier.dart';
import 'package:ohlify/shared/notifiers/toast_notifier.dart';
import 'package:ohlify/shared/services/drawer_service.dart';
import 'package:ohlify/shared/services/services.dart';
import 'package:ohlify/shared/types/scheduled_call_item.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class ProfessionalKycRatesScreen extends StatelessWidget {
  const ProfessionalKycRatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ProfessionalKycNotifier>();
    final audio =
        notifier.rates.where((r) => r.callType == CallType.audio).toList();
    final video =
        notifier.rates.where((r) => r.callType == CallType.video).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    behavior: HitTestBehavior.opaque,
                    child: const Row(
                      children: [
                        Icon(AppIcons.chevronLeft,
                            size: 22, color: AppColors.textJet),
                        SizedBox(width: 4),
                        AppText(
                          'Back',
                          variant: AppTextVariant.body,
                          color: AppColors.textJet,
                          weight: FontWeight.w500,
                          align: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  'Rates',
                  variant: AppTextVariant.title,
                  color: AppColors.textJet,
                  weight: FontWeight.w800,
                  align: TextAlign.start,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (notifier.rates.isEmpty)
                      const _EmptyState()
                    else ...[
                      RatesGroup(
                        callType: CallType.audio,
                        rates: audio,
                        onDelete: (rate) =>
                            _confirmDelete(context, notifier, rate),
                      ),
                      if (audio.isNotEmpty && video.isNotEmpty)
                        const SizedBox(height: 20),
                      RatesGroup(
                        callType: CallType.video,
                        rates: video,
                        onDelete: (rate) =>
                            _confirmDelete(context, notifier, rate),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: AppButton(
                label: 'Add rate',
                expanded: true,
                radius: 100,
                onPressed: () => _openAddRate(notifier),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openAddRate(ProfessionalKycNotifier notifier) {
    DrawerHandle? handle;
    handle = DrawerService.instance.showCustomModal(
      'Add rate',
      (_, _) => AddRateModalContent(
        onSave: (rate) {
          notifier.addRate(rate: rate);
          handle?.dismiss();
          DrawerService.instance.toast(
            'Rate added successfully',
            options: const ToastOptions(type: ToastType.success),
          );
        },
      ),
      options: const CustomModalOptions(position: ModalPosition.bottom),
    );
  }

  void _confirmDelete(
    BuildContext context,
    ProfessionalKycNotifier notifier,
    KycRate rate,
  ) {
    DrawerService.instance.showConfirmationModal(
      'Delete rate?',
      'Deleting rate would mean that no one would be able to see the rate on your profile.',
      options: ConfirmationModalOptions(
        kind: ModalConfirmationKind.error,
        destructive: true,
        confirmButtonText: 'Confirm and delete',
        cancelButtonText: 'Cancel',
        onConfirm: () {
          notifier.removeRate(rate.id);
          DrawerService.instance.toast(
            'Rate deleted successfully',
            options: const ToastOptions(type: ToastType.success),
          );
        },
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        children: [
          Icon(Icons.payments_outlined,
              size: 28, color: AppColors.textMuted),
          SizedBox(height: 10),
          AppText(
            'No rates yet',
            variant: AppTextVariant.medium,
            color: AppColors.textJet,
            weight: FontWeight.w600,
            align: TextAlign.center,
          ),
          SizedBox(height: 4),
          AppText(
            'Add your first rate to let clients book a call with you.',
            variant: AppTextVariant.body,
            color: AppColors.textMuted,
            align: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
