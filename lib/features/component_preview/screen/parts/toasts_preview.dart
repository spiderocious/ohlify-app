import 'package:flutter/material.dart';

import 'package:ohlify/shared/services/drawer_service.dart';
import 'package:ohlify/shared/notifiers/toast_notifier.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';

class ToastsPreview extends StatelessWidget {
  const ToastsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Individual types ──────────────────────────────────────────────────
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            AppButton(
              label: 'Success',
              onPressed: () => DrawerService.instance.toast(
                'Changes saved successfully.',
                options: const ToastOptions(type: ToastType.success),
              ),
            ),
            AppButton(
              label: 'Error',
              onPressed: () => DrawerService.instance.toast(
                'Something went wrong. Please try again.',
                options: const ToastOptions(type: ToastType.error),
              ),
            ),
            AppButton(
              label: 'Warning',
              onPressed: () => DrawerService.instance.toast(
                'Your session will expire in 5 minutes.',
                options: const ToastOptions(type: ToastType.warning),
              ),
            ),
            AppButton(
              label: 'Info',
              onPressed: () => DrawerService.instance.toast(
                'A new version of the app is available.',
                options: const ToastOptions(type: ToastType.info),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // ── Long text ─────────────────────────────────────────────────────────
        AppButton(
          label: 'Long text',
          variant: AppButtonVariant.outline,
          onPressed: () => DrawerService.instance.toast(
            'Your profile has been updated and your changes have been saved. '
            'It may take a few moments before the changes are reflected across all devices.',
            options: const ToastOptions(type: ToastType.info),
          ),
        ),
        const SizedBox(height: 16),

        // ── No icon ───────────────────────────────────────────────────────────
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            AppButton(
              label: 'No icon (success)',
              variant: AppButtonVariant.outline,
              onPressed: () => DrawerService.instance.toast(
                'Saved without an icon.',
                options: const ToastOptions(
                  type: ToastType.success,
                  showIcon: false,
                ),
              ),
            ),
            AppButton(
              label: 'No icon (error)',
              variant: AppButtonVariant.outline,
              onPressed: () => DrawerService.instance.toast(
                'Error — icon suppressed.',
                options: const ToastOptions(
                  type: ToastType.error,
                  showIcon: false,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // ── Bottom position ───────────────────────────────────────────────────
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            AppButton(
              label: 'Bottom toast',
              variant: AppButtonVariant.outline,
              onPressed: () => DrawerService.instance.toast(
                'Toast at the bottom of the screen.',
                options: const ToastOptions(
                  type: ToastType.info,
                  position: ToastPosition.bottom,
                ),
              ),
            ),
            AppButton(
              label: 'Sticky top',
              variant: AppButtonVariant.outline,
              onPressed: () => DrawerService.instance.toast(
                'This toast must be dismissed manually.',
                options: const ToastOptions(
                  type: ToastType.warning,
                  sticky: true,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // ── Sticky full-width, no dismiss button ──────────────────────────────
        AppButton(
          label: 'Sticky full-width (no dismiss)',
          variant: AppButtonVariant.outline,
          onPressed: () => DrawerService.instance.toast(
            'System maintenance is underway. Some features may be unavailable.',
            options: const ToastOptions(
              type: ToastType.warning,
              sticky: true,
              dismissible: false,
              fullWidth: true,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // ── Full-width demo ───────────────────────────────────────────────────
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            AppButton(
              label: 'Full-width top',
              variant: AppButtonVariant.outline,
              onPressed: () => DrawerService.instance.toast(
                'Full-width toast — no margins, no radius.',
                options: const ToastOptions(
                  type: ToastType.success,
                  fullWidth: true,
                ),
              ),
            ),
            AppButton(
              label: 'Full-width bottom',
              variant: AppButtonVariant.outline,
              onPressed: () => DrawerService.instance.toast(
                'Full-width toast at the bottom.',
                options: const ToastOptions(
                  type: ToastType.error,
                  position: ToastPosition.bottom,
                  fullWidth: true,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // ── Stacking demo ─────────────────────────────────────────────────────
        AppButton(
          label: 'Trigger 3 stacked toasts',
          variant: AppButtonVariant.subtle,
          bordered: true,
          onPressed: () {
            DrawerService.instance.toast(
              'First toast — success',
              options: const ToastOptions(type: ToastType.success),
            );
            DrawerService.instance.toast(
              'Second toast — warning',
              options: const ToastOptions(
                type: ToastType.warning,
                duration: Duration(seconds: 5),
              ),
            );
            DrawerService.instance.toast(
              'Third toast — error',
              options: const ToastOptions(
                type: ToastType.error,
                duration: Duration(seconds: 6),
              ),
            );
          },
        ),
      ],
    );
  }
}
