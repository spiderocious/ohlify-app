import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';

/// Full-bleed blurred peer-avatar backdrop used by audio calls and the
/// dialing / ringing / ended overlays. When [url] is null, a soft gradient
/// is used instead so the screen still looks intentional.
class CallBlurredBackdrop extends StatelessWidget {
  const CallBlurredBackdrop({super.key, this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (url != null)
          Image.network(url!, fit: BoxFit.cover, errorBuilder: (_, _, _) => _gradient())
        else
          _gradient(),
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: Container(color: Colors.black.withValues(alpha: 0.1)),
        ),
        Container(color: Colors.black.withValues(alpha: 0.12)),
      ],
    );
  }

  Widget _gradient() {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.post],
        ),
      ),
    );
  }
}
