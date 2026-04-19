import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

/// Placeholder for a participant's video stream. When Agora lands, swap
/// the inner `Container` for `AgoraVideoView(controller: VideoViewController(...))`.
class CallVideoTile extends StatelessWidget {
  const CallVideoTile({
    super.key,
    required this.label,
    this.isLocal = false,
    this.muted = false,
    this.imageUrl,
  });

  final String label;
  final bool isLocal;
  final bool muted;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: isLocal ? const Color(0xFF1E3A5F) : Colors.black,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (imageUrl != null)
              Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _placeholder(),
              )
            else
              _placeholder(),
            if (muted)
              const Positioned(
                right: 12,
                bottom: 12,
                child: _MutedBadge(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: isLocal ? const Color(0xFF1E3A5F) : Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.videocam_outlined,
              size: 36,
              color: Colors.white.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 8),
            AppText(
              label,
              variant: AppTextVariant.bodyNormal,
              color: Colors.white.withValues(alpha: 0.7),
              align: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _MutedBadge extends StatelessWidget {
  const _MutedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.mic_off_rounded,
        size: 18,
        color: AppColors.danger,
      ),
    );
  }
}
