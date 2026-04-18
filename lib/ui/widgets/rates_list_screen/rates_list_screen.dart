import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/shared/notifiers/modal_notifier.dart';
import 'package:ohlify/shared/notifiers/toast_notifier.dart';
import 'package:ohlify/shared/services/services.dart';
import 'package:ohlify/shared/types/call_rate.dart';
import 'package:ohlify/shared/types/rates_controller.dart';
import 'package:ohlify/shared/types/scheduled_call_item.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/add_rate_form/add_rate_form.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/rates_group/rates_group.dart';

/// Reusable "Rates" screen. Accepts any [RatesController] implementation.
///
/// Displays audio + video groups, shows delete confirmation, and offers
/// two bottom actions: "Add rate" (inline) and a primary [submitLabel]
/// button that is disabled until the controller has at least one rate.
/// [onSubmit] defaults to `context.pop()` so the screen works in a push
/// flow without extra wiring.
class RatesListScreen extends StatelessWidget {
  const RatesListScreen({
    super.key,
    required this.controller,
    this.submitLabel = 'Proceed',
    this.onSubmit,
  });

  final RatesController controller;
  final String submitLabel;
  final VoidCallback? onSubmit;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final audio = controller.rates
            .where((r) => r.callType == CallType.audio)
            .toList();
        final video = controller.rates
            .where((r) => r.callType == CallType.video)
            .toList();
        final hasRates = controller.rates.isNotEmpty;

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
                            Icon(
                              AppIcons.chevronLeft,
                              size: 22,
                              color: AppColors.textJet,
                            ),
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
                        if (!hasRates)
                          _EmptyState(onAdd: () => _openAddRate(context))
                        else ...[
                          if (audio.isNotEmpty) ...[
                            RatesGroup(
                              callType: CallType.audio,
                              rates: audio,
                              onDelete: (r) => _confirmDelete(context, r),
                            ),
                            const SizedBox(height: 20),
                          ],
                          if (video.isNotEmpty) ...[
                            RatesGroup(
                              callType: CallType.video,
                              rates: video,
                              onDelete: (r) => _confirmDelete(context, r),
                            ),
                            const SizedBox(height: 20),
                          ],
                          AppButton(
                            label: 'Add rate',
                            variant: AppButtonVariant.plain,
                            startIcon: const Icon(
                              Icons.add_rounded,
                              size: 18,
                              color: AppColors.primary,
                            ),
                            expanded: true,
                            radius: 100,
                            onPressed: () => _openAddRate(context),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: AppButton(
                    label: submitLabel,
                    expanded: true,
                    radius: 100,
                    isDisabled: !hasRates,
                    onPressed: !hasRates
                        ? null
                        : onSubmit ?? () => context.pop(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openAddRate(BuildContext context) {
    CallRate? pendingRate;
    DrawerHandle? handle;
    handle = DrawerService.instance.showCustomModal(
      'Add rate',
      (_, _) => AddRateForm(
        onSave: (rate) {
          pendingRate = rate;
          handle?.dismiss();
        },
      ),
      options: const CustomModalOptions(position: ModalPosition.bottom),
    );

    handle.onDismissed.then((_) {
      final rate = pendingRate;
      if (rate == null) return;
      controller.addRate(rate);
      DrawerService.instance.toast(
        'Rate added successfully',
        options: const ToastOptions(type: ToastType.success),
      );
    });
  }

  void _confirmDelete(BuildContext context, CallRate rate) {
    DrawerService.instance.showConfirmationModal(
      'Delete rate?',
      'Deleting rate would mean that no one would be able to see the rate on your profile.',
      options: ConfirmationModalOptions(
        kind: ModalConfirmationKind.error,
        destructive: true,
        confirmButtonText: 'Confirm and delete',
        cancelButtonText: 'Cancel',
        onConfirm: () {
          controller.removeRate(rate.id);
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
  const _EmptyState({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.payments_outlined,
            size: 28,
            color: AppColors.textMuted,
          ),
          const SizedBox(height: 10),
          const AppText(
            'No rates yet',
            variant: AppTextVariant.medium,
            color: AppColors.textJet,
            weight: FontWeight.w600,
            align: TextAlign.center,
          ),
          const SizedBox(height: 4),
          const AppText(
            'Add your first rate to let clients book a call with you.',
            variant: AppTextVariant.body,
            color: AppColors.textMuted,
            align: TextAlign.center,
          ),
          const SizedBox(height: 16),
          AppButton(
            label: 'Add rate',
            startIcon: const Icon(
              Icons.add_rounded,
              size: 18,
              color: Colors.white,
            ),
            radius: 100,
            onPressed: onAdd,
          ),
        ],
      ),
    );
  }
}
