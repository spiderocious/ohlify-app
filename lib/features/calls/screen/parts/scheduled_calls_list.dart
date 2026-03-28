import 'package:flutter/material.dart';

import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/icons/app_icons.dart'; // person icon for avatar placeholder
import 'package:ohlify/ui/icons/app_svgs.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_svg/app_svg.dart';
import 'package:ohlify/ui/widgets/app_tag/app_tag.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class ScheduledCallsList extends StatelessWidget {
  const ScheduledCallsList({
    super.key,
    required this.calls,
    required this.onCancel,
    required this.onReschedule,
    required this.onJoin,
  });

  final List<ScheduledCallItem> calls;
  final ValueChanged<ScheduledCallItem> onCancel;
  final ValueChanged<ScheduledCallItem> onReschedule;
  final ValueChanged<ScheduledCallItem> onJoin;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: calls.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, i) => _ScheduledCallCard(
        call: calls[i],
        onCancel: () => onCancel(calls[i]),
        onReschedule: () => onReschedule(calls[i]),
        onJoin: () => onJoin(calls[i]),
      ),
    );
  }
}

class _ScheduledCallCard extends StatelessWidget {
  const _ScheduledCallCard({
    required this.call,
    required this.onCancel,
    required this.onReschedule,
    required this.onJoin,
  });

  final ScheduledCallItem call;
  final VoidCallback onCancel;
  final VoidCallback onReschedule;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Inner white card — details only
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CardHeader(call: call),
                const SizedBox(height: 12),
                _CallMeta(call: call),
              ],
            ),
          ),
          // Actions sit in the outer (bluish) container
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 12, 10, 10),
            child: _CardActions(
              canReschedule: call.canReschedule,
              onCancel: onCancel,
              onReschedule: onReschedule,
              onJoin: onJoin,
            ),
          ),
        ],
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader({required this.call});

  final ScheduledCallItem call;

  @override
  Widget build(BuildContext context) {
    final isVideo = call.callType == CallType.video;

    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: call.avatarUrl != null
              ? Image.network(call.avatarUrl!, width: 56, height: 56, fit: BoxFit.cover)
              : Container(
                  width: 56,
                  height: 56,
                  color: AppColors.border,
                  child: const Icon(AppIcons.person, color: AppColors.textMuted),
                ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                call.name,
                variant: AppTextVariant.body,
                color: AppColors.textJet,
                weight: FontWeight.w500,
                align: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              AppText(
                call.role,
                variant: AppTextVariant.bodyNormal,
                color: AppColors.textMuted,
                align: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppSvg(AppSvgs.ratingBadge, size: 14),
            const SizedBox(width: 4),
            AppText(
              '${call.rating}',
              variant: AppTextVariant.body,
              color: AppColors.textAmber,
              weight: FontWeight.w700,
              align: TextAlign.start,
            ),
            const SizedBox(width: 8),
            Container(width: 1, height: 16, color: AppColors.border),
            const SizedBox(width: 8),
            AppTag(
              label: isVideo ? 'VIDEO' : 'AUDIO',
              variant: AppTagVariant.solid,
              color: isVideo ? const Color(0xFF489B08) : const Color(0xFF8F089B),
              startIcon: Icon(
                isVideo ? AppIcons.video : AppIcons.phone,
                color: Colors.white,
              ),
              size: AppTagSize.medium,
            ),
          ],
        ),
      ],
    );
  }
}

class _CallMeta extends StatelessWidget {
  const _CallMeta({required this.call});

  final ScheduledCallItem call;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _MetaItem(svgPath: AppSvgs.clock, label: call.time),
        const SizedBox(width: 16),
        _MetaItem(svgPath: AppSvgs.calendar, label: call.date),
        const SizedBox(width: 16),
        _MetaItem(svgPath: AppSvgs.stopwatch, label: call.duration),
      ],
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({required this.svgPath, required this.label});

  final String svgPath;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSvg(svgPath, size: 14),
        const SizedBox(width: 4),
        AppText(
          label,
          variant: AppTextVariant.bodyNormal,
          color: AppColors.textMuted,
          align: TextAlign.start,
        ),
      ],
    );
  }
}

class _CardActions extends StatelessWidget {
  const _CardActions({
    required this.canReschedule,
    required this.onCancel,
    required this.onReschedule,
    required this.onJoin,
  });

  final bool canReschedule;
  final VoidCallback onCancel;
  final VoidCallback onReschedule;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    if (canReschedule) {
      return Row(
        children: [
          Expanded(
            child: AppButton(
              label: 'Cancel',
              variant: AppButtonVariant.outline,
              onPressed: onCancel,
              radius: 100,
              height: 44,
              textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppButton(
              label: 'Reschedule',
              onPressed: onReschedule,
              radius: 100,
              height: 44,
              textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      );
    }

    return AppButton(
      label: 'Join call',
      onPressed: onJoin,
      expanded: true,
      radius: 100,
      height: 44,
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    );
  }
}
