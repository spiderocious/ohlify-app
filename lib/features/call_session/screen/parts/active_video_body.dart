import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/features/call_session/providers/call_session_notifier.dart';
import 'package:ohlify/features/call_session/screen/parts/call_controls_row.dart';
import 'package:ohlify/features/call_session/screen/parts/call_video_tile.dart';
import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/widgets/app_icon_button/app_icon_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

/// Active video call: stacked peer + self tiles, top bar with timer + speaker,
/// bottom controls.
class ActiveVideoBody extends StatelessWidget {
  const ActiveVideoBody({super.key, required this.notifier});

  final CallSessionNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final isConnecting = notifier.phase is CallPhaseConnecting;

    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Column(
          children: [
            _TopBar(notifier: notifier, isConnecting: isConnecting),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: Column(
                  children: [
                    Expanded(
                      child: CallVideoTile(
                        label: notifier.config.peerName,
                        imageUrl: notifier.config.peerAvatarUrl,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: CallVideoTile(
                        label: 'You',
                        isLocal: true,
                        muted: notifier.muted,
                        imageUrl: notifier.config.selfAvatarUrl,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CallControlsRow(notifier: notifier),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.notifier, required this.isConnecting});

  final CallSessionNotifier notifier;
  final bool isConnecting;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      child: Row(
        children: [
          AppIconButton(
            icon: const Icon(AppIcons.back, color: Colors.white),
            variant: AppIconButtonVariant.ghost,
            backgroundColor: Colors.white.withValues(alpha: 0.15),
            size: 40,
            iconSize: 20,
            onPressed: () {
              if (context.canPop()) context.pop();
            },
          ),
          const Spacer(),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              notifier.speakerOn
                  ? Icons.volume_up_rounded
                  : Icons.volume_off_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isConnecting
                  ? const Color(0xFFA03535)
                  : Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(100),
            ),
            child: AppText(
              isConnecting ? 'Ringing' : notifier.elapsedLabel,
              variant: AppTextVariant.bodyNormal,
              color: Colors.white,
              weight: FontWeight.w600,
              align: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
