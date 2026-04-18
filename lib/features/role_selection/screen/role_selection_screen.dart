import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/features/role_selection/screen/parts/role_card.dart';
import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/shared/notifiers/modal_notifier.dart';
import 'package:ohlify/shared/services/services.dart';
import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  Role? _selected;

  void _onContinue() {
    final role = _selected;
    if (role == null) return;

    final confirmation = DrawerService.instance.showConfirmationModal(
      'Continue as ${role.label}?',
      role == Role.professional
          ? 'You will need to complete a short profile so clients can discover and book you.'
          : 'You will be able to browse and book professionals right away. You can switch later.',
      options: ConfirmationModalOptions(
        kind: ModalConfirmationKind.info,
        confirmButtonText: 'Yes, continue',
        cancelButtonText: 'Change',
        // Capture the confirm intent — wait for the modal to fully dismiss
        // before pushing the feedback modal so they don't overlap.
        onConfirm: () => _confirmed = true,
      ),
    );

    confirmation.onDismissed.then((_) {
      if (!_confirmed || !mounted) return;
      _confirmed = false;
      _onConfirmed(role);
    });
  }

  bool _confirmed = false;

  void _onConfirmed(Role role) {
    DrawerService.instance.showFeedbackModal(
      'Role saved successfully',
      role == Role.professional
          ? 'You are all set as a Professional. Let\'s complete your profile next.'
          : 'You are all set as a Client. Find a professional and book a call whenever you are ready.',
      options: FeedbackModalOptions(
        kind: ModalFeedbackKind.success,
        position: ModalPosition.fullscreen,
        showCloseButton: false,
        dismissible: false,
        confirmButtonText: role == Role.professional
            ? 'Complete my profile'
            : 'Go to home',
        onConfirm: () {
          if (!mounted) return;
          context.go(
            role == Role.professional
                ? AppRoutes.professionalKyc
                : AppRoutes.home,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppText(
                      'How will you use Ohlify?',
                      variant: AppTextVariant.title,
                      color: AppColors.textJet,
                      weight: FontWeight.w800,
                      align: TextAlign.start,
                    ),
                    const SizedBox(height: 6),
                    const AppText(
                      'Pick the option that fits best. You can change this later from your profile settings.',
                      variant: AppTextVariant.body,
                      color: AppColors.textMuted,
                      align: TextAlign.start,
                    ),
                    const SizedBox(height: 24),
                    RoleCard(
                      title: 'I\'m a Client',
                      subtitle:
                          'Find and book short paid calls with experts across any field.',
                      icon: Icons.search_rounded,
                      bullets: const [
                        'Browse verified professionals',
                        'Book audio or video calls',
                        'Pay per minute, no subscription',
                      ],
                      selected: _selected == Role.client,
                      onTap: () => setState(() => _selected = Role.client),
                    ),
                    const SizedBox(height: 14),
                    RoleCard(
                      title: 'I\'m a Professional',
                      subtitle:
                          'Get paid for your time. Let people book short calls with you.',
                      icon: Icons.workspace_premium_rounded,
                      bullets: const [
                        'Set your own rates and availability',
                        'Accept audio or video bookings',
                        'Withdraw earnings to your bank',
                      ],
                      selected: _selected == Role.professional,
                      onTap: () =>
                          setState(() => _selected = Role.professional),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: AppButton(
                label: 'Continue',
                expanded: true,
                radius: 100,
                isDisabled: _selected == null,
                onPressed: _selected == null ? null : _onContinue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
