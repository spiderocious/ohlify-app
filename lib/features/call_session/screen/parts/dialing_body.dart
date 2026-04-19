import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/features/call_session/providers/call_session_notifier.dart';
import 'package:ohlify/features/call_session/screen/parts/call_avatar.dart';
import 'package:ohlify/features/call_session/screen/parts/call_blurred_backdrop.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_icon_button/app_icon_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

/// Caller's pre-answer view. Blurred peer avatar backdrop, small avatar
/// centered, name + "Ringing" pill with an end-call button.
class DialingBody extends StatelessWidget {
  const DialingBody({super.key, required this.notifier});

  final CallSessionNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CallBlurredBackdrop(url: notifier.config.peerAvatarUrl),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.topLeft,
              child: AppIconButton(
                icon: const Icon(AppIcons.back, color: Colors.white),
                variant: AppIconButtonVariant.ghost,
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                size: 44,
                iconSize: 20,
                onPressed: () {
                  notifier.hangup();
                  if (context.canPop()) context.pop();
                },
              ),
            ),
          ),
        ),
        Center(
          child: CallAvatar(url: notifier.config.peerAvatarUrl, size: 96),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 32,
          child: _RingingPill(notifier: notifier),
        ),
      ],
    );
  }
}

class _RingingPill extends StatelessWidget {
  const _RingingPill({required this.notifier});

  final CallSessionNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          CallAvatar(url: notifier.config.peerAvatarUrl, size: 48),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  notifier.config.peerName,
                  variant: AppTextVariant.body,
                  color: Colors.white,
                  weight: FontWeight.w700,
                  align: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                AppText(
                  'Ringing',
                  variant: AppTextVariant.bodyNormal,
                  color: Colors.white.withValues(alpha: 0.75),
                  align: TextAlign.start,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: notifier.hangup,
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: AppColors.danger,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.call_end_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
