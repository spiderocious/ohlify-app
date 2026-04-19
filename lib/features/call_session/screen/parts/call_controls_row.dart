import 'package:flutter/material.dart';

import 'package:ohlify/features/call_session/providers/call_session_notifier.dart';
import 'package:ohlify/features/call_session/screen/parts/call_control_button.dart';
import 'package:ohlify/ui/theme/app_colors.dart';

/// Bottom control cluster shown during an active call. Covers both audio
/// and video layouts — the end-call button is always red and centered.
class CallControlsRow extends StatelessWidget {
  const CallControlsRow({super.key, required this.notifier});

  final CallSessionNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final isVideo = notifier.config.isVideo;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CallControlButton(
            icon: notifier.muted ? Icons.mic_off_rounded : Icons.mic_rounded,
            active: notifier.muted,
            onTap: notifier.toggleMute,
          ),
          const SizedBox(width: 12),
          CallControlButton(
            icon: notifier.speakerOn
                ? Icons.volume_up_rounded
                : Icons.volume_off_rounded,
            active: notifier.speakerOn,
            onTap: notifier.toggleSpeaker,
          ),
          const SizedBox(width: 12),
          CallControlButton(
            icon: Icons.call_end_rounded,
            background: AppColors.danger,
            iconColor: Colors.white,
            size: 62,
            onTap: notifier.hangup,
          ),
          const SizedBox(width: 12),
          CallControlButton(
            icon: Icons.chat_bubble_outline_rounded,
            onTap: () {},
          ),
          const SizedBox(width: 12),
          CallControlButton(
            icon: isVideo ? Icons.cameraswitch_rounded : Icons.more_horiz_rounded,
            onTap: isVideo ? notifier.switchCamera : () {},
          ),
        ],
      ),
    );
  }
}
