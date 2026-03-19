import 'package:flutter/material.dart';

import 'package:ohlify/shared/notifiers/modal_notifier.dart';
import 'package:ohlify/shared/services/drawer_service.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';

class ModalsPreview extends StatelessWidget {
  const ModalsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Feedback ──────────────────────────────────────────────────────────
        _label('Feedback'),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            AppButton(
              label: 'Success',
              onPressed: () => DrawerService.instance.showFeedbackModal(
                'Profile completed',
                'You have successfully completed your profile and can now go into your home page.',
                options: const FeedbackModalOptions(kind: ModalFeedbackKind.success),
              ),
            ),
            AppButton(
              label: 'Error',
              onPressed: () => DrawerService.instance.showFeedbackModal(
                'Payment failed',
                'We were unable to process your payment. Please check your card details and try again.',
                options: const FeedbackModalOptions(kind: ModalFeedbackKind.error),
              ),
            ),
            AppButton(
              label: 'Warning',
              onPressed: () => DrawerService.instance.showFeedbackModal(
                'Complete Profile',
                'You need to fill some information and create a profile before you can view others profile or make a call.',
                options: const FeedbackModalOptions(
                  kind: ModalFeedbackKind.warning,
                  confirmButtonText: 'Proceed',
                ),
              ),
            ),
            AppButton(
              label: 'Info',
              onPressed: () => DrawerService.instance.showFeedbackModal(
                'Add Bank Account',
                'Before you proceed, you need to add a bank account for withdrawal.',
                options: const FeedbackModalOptions(
                  kind: ModalFeedbackKind.info,
                  confirmButtonText: 'Proceed',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            AppButton(
              label: 'With secondary action',
              variant: AppButtonVariant.outline,
              onPressed: () => DrawerService.instance.showFeedbackModal(
                'Call Schedule Successfully',
                'You have successfully booked a call time with Pal Osuofia for 12/02/2026, 10:00AM. You will receive a call from him when it\'s time.',
                options: FeedbackModalOptions(
                  kind: ModalFeedbackKind.success,
                  confirmButtonText: 'Done',
                  actionLabel: 'View booking',
                  onAction: () {},
                ),
              ),
            ),
            AppButton(
              label: 'No close, not dismissible',
              variant: AppButtonVariant.outline,
              onPressed: () => DrawerService.instance.showFeedbackModal(
                'Session expired',
                'Your session has expired. Please log in again to continue.',
                options: const FeedbackModalOptions(
                  kind: ModalFeedbackKind.error,
                  showCloseButton: false,
                  dismissible: false,
                ),
              ),
            ),
            AppButton(
              label: 'Auto-dismiss',
              variant: AppButtonVariant.outline,
              onPressed: () => DrawerService.instance.showFeedbackModal(
                'Saved',
                'Your changes were saved automatically.',
                options: const FeedbackModalOptions(
                  kind: ModalFeedbackKind.success,
                  autoDismiss: true,
                  autoDismissDuration: Duration(seconds: 2),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // ── Confirmation ──────────────────────────────────────────────────────
        _label('Confirmation — kinds'),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            AppButton(
              label: 'Neutral',
              onPressed: () => DrawerService.instance.showConfirmationModal(
                'Are you sure?',
                'This action cannot be undone. Please confirm you want to continue.',
                options: ConfirmationModalOptions(
                  kind: ModalConfirmationKind.neutral,
                  onConfirm: () {},
                ),
              ),
            ),
            AppButton(
              label: 'Success',
              onPressed: () => DrawerService.instance.showConfirmationModal(
                'Confirm booking',
                'You are about to confirm your session with Pal Osuofia for 12/02/2026, 10:00AM.',
                options: ConfirmationModalOptions(
                  kind: ModalConfirmationKind.success,
                  confirmButtonText: 'Confirm booking',
                  onConfirm: () {},
                ),
              ),
            ),
            AppButton(
              label: 'Warning',
              onPressed: () => DrawerService.instance.showConfirmationModal(
                'Leave session?',
                'Are you sure you want to leave? Your progress will not be saved.',
                options: ConfirmationModalOptions(
                  kind: ModalConfirmationKind.warning,
                  confirmButtonText: 'Leave',
                  onConfirm: () {},
                ),
              ),
            ),
            AppButton(
              label: 'Info',
              onPressed: () => DrawerService.instance.showConfirmationModal(
                'Enable notifications',
                'Allow Ohlify to send you push notifications so you never miss a session.',
                options: ConfirmationModalOptions(
                  kind: ModalConfirmationKind.info,
                  confirmButtonText: 'Enable',
                  cancelButtonText: 'Not now',
                  onConfirm: () {},
                ),
              ),
            ),
            AppButton(
              label: 'Destructive',
              onPressed: () => DrawerService.instance.showConfirmationModal(
                'Delete account',
                'Your account and all associated data will be permanently deleted. This cannot be reversed.',
                options: ConfirmationModalOptions(
                  kind: ModalConfirmationKind.error,
                  confirmButtonText: 'Delete',
                  destructive: true,
                  onConfirm: () {},
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _label('Confirmation — variants'),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            AppButton(
              label: 'No icon',
              variant: AppButtonVariant.outline,
              onPressed: () => DrawerService.instance.showConfirmationModal(
                'Log out',
                'Are you sure you want to log out of your account?',
                options: ConfirmationModalOptions(
                  showIcon: false,
                  confirmButtonText: 'Log out',
                  onConfirm: () {},
                ),
              ),
            ),
            AppButton(
              label: 'No cancel',
              variant: AppButtonVariant.outline,
              onPressed: () => DrawerService.instance.showConfirmationModal(
                'Update required',
                'A critical update is required before you can continue using the app.',
                options: ConfirmationModalOptions(
                  kind: ModalConfirmationKind.warning,
                  confirmButtonText: 'Update now',
                  showCancelButton: false,
                  dismissible: false,
                  showCloseButton: false,
                  onConfirm: () {},
                ),
              ),
            ),
            AppButton(
              label: 'No close icon',
              variant: AppButtonVariant.outline,
              onPressed: () => DrawerService.instance.showConfirmationModal(
                'Confirm payment',
                'You are about to pay ₦12,500 for a 30-minute session. Proceed?',
                options: ConfirmationModalOptions(
                  kind: ModalConfirmationKind.info,
                  confirmButtonText: 'Pay now',
                  showCloseButton: false,
                  onConfirm: () {},
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // ── Input ─────────────────────────────────────────────────────────────
        _label('Input'),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            AppButton(
              label: 'Text',
              onPressed: () => DrawerService.instance.showInputModal(
                'Create your username',
                'Set your preferred username for your account.',
                options: InputModalOptions(
                  stepLabel: '1/4',
                  placeholder: 'Adedeji23',
                  confirmButtonText: 'Save and proceed',
                  onConfirm: (v) {},
                ),
              ),
            ),
            AppButton(
              label: 'Email',
              onPressed: () => DrawerService.instance.showInputModal(
                'Enter your email',
                'We\'ll send a verification link to this address.',
                options: InputModalOptions(
                  stepLabel: '2/4',
                  inputType: InputModalInputType.email,
                  placeholder: 'you@example.com',
                  startIcon: const Icon(Icons.mail_outline_rounded,
                      size: 18, color: AppColors.textSlate),
                  regex: RegExp(r'^[\w.-]+@[\w.-]+\.\w{2,}$'),
                  errorMessage: 'Please enter a valid email address.',
                  confirmButtonText: 'Continue',
                  onConfirm: (v) {},
                ),
              ),
            ),
            AppButton(
              label: 'Number',
              variant: AppButtonVariant.outline,
              onPressed: () => DrawerService.instance.showInputModal(
                'Enter your age',
                'We use this to personalise your experience.',
                options: InputModalOptions(
                  inputType: InputModalInputType.number,
                  placeholder: 'e.g. 25',
                  startIcon: const Icon(Icons.cake_outlined,
                      size: 18, color: AppColors.textSlate),
                  confirmButtonText: 'Save',
                  onConfirm: (v) {},
                ),
              ),
            ),
            AppButton(
              label: 'Password',
              variant: AppButtonVariant.outline,
              onPressed: () => DrawerService.instance.showInputModal(
                'Create a PIN',
                'Set a 4-digit PIN to secure your account.',
                options: InputModalOptions(
                  inputType: InputModalInputType.password,
                  placeholder: '••••',
                  maxLength: 4,
                  confirmButtonText: 'Set PIN',
                  onConfirm: (v) {},
                ),
              ),
            ),
            AppButton(
              label: 'With validation',
              variant: AppButtonVariant.outline,
              onPressed: () => DrawerService.instance.showInputModal(
                'Enter promo code',
                'Enter a valid promo code to get a discount on your next session.',
                options: InputModalOptions(
                  placeholder: 'e.g. OHLIFY25',
                  endIcon: const Icon(Icons.discount_outlined,
                      size: 18, color: AppColors.textSlate),
                  regex: RegExp(r'^[A-Z0-9]{4,12}$'),
                  errorMessage: 'Code must be 4–12 uppercase letters or digits.',
                  confirmButtonText: 'Apply',
                  onConfirm: (v) {},
                ),
              ),
            ),
            AppButton(
              label: 'No cancel',
              variant: AppButtonVariant.outline,
              onPressed: () => DrawerService.instance.showInputModal(
                'Set a display name',
                'This is how other users will see you on the platform.',
                options: InputModalOptions(
                  stepLabel: '3/4',
                  placeholder: 'e.g. Feranmi',
                  maxLength: 30,
                  showCancelButton: false,
                  confirmButtonText: 'Save',
                  onConfirm: (v) {},
                ),
              ),
            ),
            AppButton(
              label: 'Multiline bio',
              variant: AppButtonVariant.outline,
              onPressed: () => DrawerService.instance.showInputModal(
                'Write your bio',
                'Tell the community a little about yourself and what you do.',
                options: InputModalOptions(
                  stepLabel: '4/4',
                  placeholder:
                      'I am a product designer with 5+ years of experience...',
                  multiline: true,
                  maxLength: 200,
                  confirmButtonText: 'Save and proceed',
                  onConfirm: (v) {},
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // ── Fullscreen ────────────────────────────────────────────────────────
        _label('Fullscreen'),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            AppButton(
              label: 'Feedback',
              onPressed: () => DrawerService.instance.showFeedbackModal(
                'Profile completed',
                'You have successfully completed your profile and can now go into your home page.',
                options: const FeedbackModalOptions(
                  kind: ModalFeedbackKind.success,
                  position: ModalPosition.fullscreen,
                ),
              ),
            ),
            AppButton(
              label: 'Confirmation',
              onPressed: () => DrawerService.instance.showConfirmationModal(
                'Delete account',
                'Your account and all associated data will be permanently deleted. This cannot be reversed.',
                options: ConfirmationModalOptions(
                  kind: ModalConfirmationKind.error,
                  confirmButtonText: 'Delete',
                  destructive: true,
                  position: ModalPosition.fullscreen,
                  onConfirm: () {},
                ),
              ),
            ),
            AppButton(
              label: 'Input',
              onPressed: () => DrawerService.instance.showInputModal(
                'Write your bio',
                'Tell the community a little about yourself and what you do.',
                options: InputModalOptions(
                  placeholder: 'I am a product designer with 5+ years of experience...',
                  multiline: true,
                  maxLength: 200,
                  confirmButtonText: 'Save and proceed',
                  position: ModalPosition.fullscreen,
                  onConfirm: (v) {},
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontFamily: 'MonaSans',
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Color(0xFF68707E),
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
