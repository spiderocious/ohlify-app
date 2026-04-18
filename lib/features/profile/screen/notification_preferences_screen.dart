import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ohlify/features/profile/providers/profile_notifier.dart';
import 'package:ohlify/features/profile/screen/parts/profile_subscreen_scaffold.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class NotificationPreferencesScreen extends StatelessWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileNotifier>();

    return ProfileSubscreenScaffold(
      title: 'Notifications',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ToggleRow(
            title: 'SMS Notifications',
            subtitle: 'Receive alerts and promos in your SMS',
            value: profile.smsNotifications,
            onChanged: profile.setSmsNotifications,
          ),
          const Divider(height: 24, thickness: 1, color: AppColors.border),
          _ToggleRow(
            title: 'Email Notifications',
            subtitle: 'Receive alerts and promos in your mail',
            value: profile.emailNotifications,
            onChanged: profile.setEmailNotifications,
          ),
        ],
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                title,
                variant: AppTextVariant.medium,
                color: AppColors.textJet,
                weight: FontWeight.w700,
                align: TextAlign.start,
              ),
              const SizedBox(height: 4),
              AppText(
                subtitle,
                variant: AppTextVariant.body,
                color: AppColors.textMuted,
                align: TextAlign.start,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: Colors.white,
          activeTrackColor: AppColors.success,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: AppColors.border,
        ),
      ],
    );
  }
}
