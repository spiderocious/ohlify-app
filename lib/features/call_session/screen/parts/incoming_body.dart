import 'package:flutter/material.dart';

import 'package:ohlify/features/call_session/providers/call_session_notifier.dart';
import 'package:ohlify/features/call_session/screen/parts/call_avatar.dart';
import 'package:ohlify/features/call_session/screen/parts/call_blurred_backdrop.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

/// Callee pre-answer view. Accept (green) + Decline (red) buttons.
class IncomingBody extends StatelessWidget {
  const IncomingBody({super.key, required this.notifier});

  final CallSessionNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CallBlurredBackdrop(url: notifier.config.peerAvatarUrl),
        SafeArea(
          child: Column(
            children: [
              const Spacer(),
              CallAvatar(url: notifier.config.peerAvatarUrl, size: 120),
              const SizedBox(height: 20),
              AppText(
                notifier.config.peerName,
                variant: AppTextVariant.header,
                color: Colors.white,
                weight: FontWeight.w700,
                align: TextAlign.center,
              ),
              const SizedBox(height: 6),
              AppText(
                'Incoming ${notifier.config.isVideo ? 'video' : 'audio'} call',
                variant: AppTextVariant.body,
                color: Colors.white.withValues(alpha: 0.8),
                align: TextAlign.center,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 48,
                  vertical: 40,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _AnswerButton(
                      color: AppColors.danger,
                      icon: Icons.call_end_rounded,
                      label: 'Decline',
                      onTap: notifier.hangup,
                    ),
                    _AnswerButton(
                      color: AppColors.success,
                      icon: Icons.call_rounded,
                      label: 'Accept',
                      onTap: notifier.accept,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AnswerButton extends StatelessWidget {
  const _AnswerButton({
    required this.color,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final Color color;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
        ),
        const SizedBox(height: 10),
        AppText(
          label,
          variant: AppTextVariant.bodyNormal,
          color: Colors.white,
          align: TextAlign.center,
        ),
      ],
    );
  }
}
