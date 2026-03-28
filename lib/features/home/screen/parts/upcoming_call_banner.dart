import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class UpcomingCallBanner extends StatelessWidget {
  const UpcomingCallBanner({
    super.key,
    required this.calleeName,
    required this.scheduledTime,
    required this.onJoin,
  });

  final String calleeName;
  final String scheduledTime;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          _Avatar(),
          const SizedBox(width: 16),
          Expanded(
            child: _CallInfo(
              calleeName: calleeName,
              scheduledTime: scheduledTime,
            ),
          ),
          const SizedBox(width: 12),
          AppButton(
            label: 'Join meeting',
            onPressed: onJoin,
            width: 120,
            height: 48,
            radius: 100,
            textStyle: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 72,
        height: 72,
        color: AppColors.border,
        child: const Icon(
          Icons.person,
          size: 40,
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}

class _CallInfo extends StatelessWidget {
  const _CallInfo({required this.calleeName, required this.scheduledTime});

  final String calleeName;
  final String scheduledTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'Meeting with\n$calleeName',
          variant: AppTextVariant.body,
          align: TextAlign.start,
          color: AppColors.textJet,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontFamily: 'MonaSans',
              fontSize: 14,
              color: AppColors.textMuted,
            ),
            children: [
              const TextSpan(text: 'Starting in '),
              TextSpan(
                text: scheduledTime,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textJet,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

