import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';

class AppErrorState extends StatelessWidget {
  const AppErrorState({super.key, this.error, this.message});

  final Object? error;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final text = message ?? 'Something went wrong.';
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: AppColors.error, size: 40),
            const SizedBox(height: 12),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.error),
            ),
          ],
        ),
      ),
    );
  }
}
