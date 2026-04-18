import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:ohlify/features/profile/providers/profile_notifier.dart';
import 'package:ohlify/shared/notifiers/modal_notifier.dart';
import 'package:ohlify/shared/notifiers/toast_notifier.dart';
import 'package:ohlify/shared/services/services.dart';
import 'package:ohlify/shared/types/bank_details.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_icon_button/app_icon_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/bank_account_form/bank_account_form.dart';

class BankAccountScreen extends StatelessWidget {
  const BankAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileNotifier>();
    final account = profile.bankAccount;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _HeroCard(
            account: account,
            onClose: () => context.pop(),
          ),
          const Expanded(child: SizedBox.shrink()),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              child: Column(
                children: [
                  AppButton(
                    label: 'Edit account',
                    variant: AppButtonVariant.outline,
                    expanded: true,
                    radius: 100,
                    onPressed: account == null
                        ? null
                        : () => _openForm(
                              context,
                              profile,
                              title: 'Edit account',
                              initial: account,
                            ),
                  ),
                  const SizedBox(height: 10),
                  AppButton(
                    label: 'Change bank account',
                    expanded: true,
                    radius: 100,
                    onPressed: () => _openForm(
                      context,
                      profile,
                      title: 'Change bank account',
                      initial: null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openForm(
    BuildContext context,
    ProfileNotifier profile, {
    required String title,
    required BankDetails? initial,
  }) {
    BankDetails? pendingDetails;
    DrawerHandle? handle;
    handle = DrawerService.instance.showCustomModal(
      title,
      (_, _) => BankAccountForm(
        initial: initial,
        description:
            'Changing your bank account will affect where you receive your payouts',
        resolvedAccountName: initial?.accountName,
        onSave: (details) {
          pendingDetails = details;
          handle?.dismiss();
        },
      ),
      options: const CustomModalOptions(position: ModalPosition.center),
    );

    handle.onDismissed.then((_) {
      final details = pendingDetails;
      if (details == null) return;
      profile.setBankAccount(details);
      DrawerService.instance.toast(
        'Bank account saved',
        options: const ToastOptions(type: ToastType.success),
      );
    });
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.account, required this.onClose});

  final BankDetails? account;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: AppColors.primary),
      child: SafeArea(
        bottom: false,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppIconButton(
                    icon: const Icon(AppIcons.close, color: Colors.white),
                    variant: AppIconButtonVariant.ghost,
                    backgroundColor: Colors.transparent,
                    size: 40,
                    iconSize: 20,
                    onPressed: onClose,
                  ),
                  const SizedBox(height: 32),
                  AppText(
                    account?.accountNumber ?? 'No account yet',
                    variant: AppTextVariant.title,
                    color: Colors.white,
                    weight: FontWeight.w800,
                    align: TextAlign.start,
                  ),
                  const SizedBox(height: 6),
                  AppText(
                    account?.accountName ??
                        (account == null
                            ? 'Add a bank account to get paid'
                            : 'Verified account'),
                    variant: AppTextVariant.body,
                    color: Colors.white.withValues(alpha: 0.85),
                    align: TextAlign.start,
                  ),
                  const SizedBox(height: 36),
                ],
              ),
            ),
            Positioned(
              right: 0,
              bottom: -30,
              child: Icon(
                Icons.account_balance_rounded,
                size: 200,
                color: Colors.white.withValues(alpha: 0.18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
