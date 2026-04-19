import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/features/call_session/providers/call_session_notifier.dart';
import 'package:ohlify/features/call_session/screen/parts/call_avatar.dart';
import 'package:ohlify/features/call_session/screen/parts/call_blurred_backdrop.dart';
import 'package:ohlify/features/call_session/screen/parts/call_controls_row.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/widgets/app_icon_button/app_icon_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

/// Active audio call: blurred backdrop, centered avatar, name + timer pill,
/// bottom controls.
class ActiveAudioBody extends StatelessWidget {
  const ActiveAudioBody({super.key, required this.notifier});

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
                  if (context.canPop()) context.pop();
                },
              ),
            ),
          ),
        ),
        Center(child: CallAvatar(url: notifier.config.peerAvatarUrl, size: 110)),
        Positioned(
          left: 20,
          right: 20,
          bottom: 120,
          child: _InfoPill(notifier: notifier),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 24,
          child: Center(child: CallControlsRow(notifier: notifier)),
        ),
      ],
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.notifier});

  final CallSessionNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
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
                  notifier.elapsedLabel,
                  variant: AppTextVariant.bodyNormal,
                  color: Colors.white.withValues(alpha: 0.75),
                  align: TextAlign.start,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              notifier.muted ? Icons.mic_off_rounded : Icons.mic_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}
