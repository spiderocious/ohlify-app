import 'package:flutter/material.dart';

import 'package:ohlify/features/profile/screen/parts/profile_subscreen_scaffold.dart';
import 'package:ohlify/shared/notifiers/toast_notifier.dart';
import 'package:ohlify/shared/services/services.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class HelpDeskScreen extends StatelessWidget {
  const HelpDeskScreen({super.key});

  void _placeholder(String kind) {
    DrawerService.instance.toast(
      'Opening $kind is not wired up yet in this build.',
      options: const ToastOptions(type: ToastType.info),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProfileSubscreenScaffold(
      title: 'Help desk',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppText(
            'Need help? Our customer service team is ready to assist you.',
            variant: AppTextVariant.body,
            color: AppColors.textMuted,
            align: TextAlign.start,
          ),
          const SizedBox(height: 24),
          _ContactRow(
            icon: Icons.send_rounded,
            iconBg: const Color(0xFFE0E7FF),
            iconColor: AppColors.primary,
            title: 'Send us an Email',
            subtitle: 'Have feedback or need support? Send us a mail',
            actionLabel: 'info@ohlify.com',
            actionIcon: Icons.open_in_new_rounded,
            onAction: () => _placeholder('email'),
          ),
          const SizedBox(height: 16),
          _ContactRow(
            icon: Icons.headset_mic_outlined,
            iconBg: const Color(0xFFE0F2FE),
            iconColor: const Color(0xFF0284C7),
            title: 'FAQs',
            subtitle: 'See Frequently Asked Questions',
            onAction: () => _placeholder('FAQs'),
          ),
          const SizedBox(height: 16),
          _ContactRow(
            icon: Icons.chat_bubble_outline_rounded,
            iconBg: const Color(0xFFDCFCE7),
            iconColor: const Color(0xFF16A34A),
            title: 'WhatsApp',
            subtitle: 'WhatsApp support is available 24/7',
            actionLabel: '+234 812 373 4966',
            onAction: () => _placeholder('WhatsApp'),
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onAction,
    this.actionLabel,
    this.actionIcon,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String? actionLabel;
  final IconData? actionIcon;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
          child: Icon(icon, size: 20, color: iconColor),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                title,
                variant: AppTextVariant.body,
                color: AppColors.textJet,
                weight: FontWeight.w700,
                align: TextAlign.start,
              ),
              const SizedBox(height: 4),
              AppText(
                subtitle,
                variant: AppTextVariant.bodyNormal,
                color: AppColors.textMuted,
                align: TextAlign.start,
              ),
              if (actionLabel != null) ...[
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: onAction,
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        actionLabel!,
                        variant: AppTextVariant.body,
                        color: AppColors.primary,
                        weight: FontWeight.w600,
                        align: TextAlign.start,
                      ),
                      if (actionIcon != null) ...[
                        const SizedBox(width: 6),
                        Icon(actionIcon, size: 14, color: AppColors.primary),
                      ],
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
