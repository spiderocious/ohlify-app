import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';

class CallAvatar extends StatelessWidget {
  const CallAvatar({super.key, required this.url, this.size = 96});

  final String? url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: url != null
            ? Image.network(
                url!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _placeholder(),
              )
            : _placeholder(),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: AppColors.surface,
      child: Icon(Icons.person, size: size * 0.45, color: AppColors.textMuted),
    );
  }
}
