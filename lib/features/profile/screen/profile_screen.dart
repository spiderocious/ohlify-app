import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:ohlify/features/profile/helpers/delete_account_flow.dart';
import 'package:ohlify/features/profile/providers/profile_notifier.dart';
import 'package:ohlify/features/profile/screen/parts/profile_link_card.dart';
import 'package:ohlify/features/profile/screen/parts/profile_menu.dart';
import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/shared/notifiers/modal_notifier.dart';
import 'package:ohlify/shared/services/services.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const _profileUrl = 'www.ohlify.com/profile/seidu23';

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileNotifier>();

    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              _ProfileHeader(name: profile.fullName),
              const SizedBox(height: 20),
              ProfileLinkCard(
                profileUrl: _profileUrl,
                onCopy: () {},
              ),
              const SizedBox(height: 28),
              ProfileMenu(
                onPersonalInfo: () =>
                    context.push(AppRoutes.profilePersonalInfo),
                onRates: () => context.push(AppRoutes.profileRates),
                onBankAccount: () => context.push(AppRoutes.profileBankAccount),
                onChangePassword: () =>
                    context.push(AppRoutes.profileChangePassword),
                onNotifications: () =>
                    context.push(AppRoutes.profileNotifications),
                onHelpDesk: () => context.push(AppRoutes.profileHelpDesk),
                onPrivacyPolicy: () =>
                    context.push(AppRoutes.profilePrivacyPolicy),
                onEula: () => context.push(AppRoutes.profileEula),
                onTerms: () => context.push(AppRoutes.profileTerms),
                onDeleteAccount: () => startDeleteAccountFlow(
                  context,
                  emailForOtp: profile.email,
                ),
                onLogout: () => _confirmLogout(context),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    var confirmed = false;
    final handle = DrawerService.instance.showConfirmationModal(
      'Log out?',
      'You will need to sign in again to book or receive calls.',
      options: ConfirmationModalOptions(
        kind: ModalConfirmationKind.warning,
        confirmButtonText: 'Log out',
        cancelButtonText: 'Stay signed in',
        onConfirm: () => confirmed = true,
      ),
    );
    handle.onDismissed.then((_) {
      if (!confirmed || !context.mounted) return;
      context.go(AppRoutes.login);
    });
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText(
                'Your Profile',
                variant: AppTextVariant.title,
                color: AppColors.textJet,
                align: TextAlign.start,
                weight: FontWeight.w800,
              ),
              const SizedBox(height: 2),
              AppText(
                name,
                variant: AppTextVariant.body,
                color: AppColors.textMuted,
                align: TextAlign.start,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFF4ECDC4),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ],
    );
  }
}
