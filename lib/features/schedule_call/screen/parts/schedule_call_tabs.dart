import 'package:flutter/material.dart';

import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_icon_button/app_icon_button.dart';

/// Row of action buttons under the hero: Details / Rates open modals;
/// video / audio icons pick a call type.
class ScheduleCallActions extends StatelessWidget {
  const ScheduleCallActions({
    super.key,
    required this.onDetails,
    required this.onRates,
    required this.onVideo,
    required this.onAudio,
  });

  final VoidCallback onDetails;
  final VoidCallback onRates;
  final VoidCallback onVideo;
  final VoidCallback onAudio;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          AppButton(
            label: 'Details',
            onPressed: onDetails,
            radius: 100,
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 10),
          AppButton(
            label: 'Rates',
            variant: AppButtonVariant.outline,
            onPressed: onRates,
            radius: 100,
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          AppIconButton(
            icon: const Icon(AppIcons.video, color: Colors.white),
            size: 44,
            onPressed: onVideo,
          ),
          const SizedBox(width: 8),
          AppIconButton(
            icon: const Icon(AppIcons.phone, color: Colors.white),
            size: 44,
            onPressed: onAudio,
          ),
        ],
      ),
    );
  }
}
