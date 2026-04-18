import 'package:flutter/material.dart';

import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_tag/app_tag.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class CompletedCallsList extends StatelessWidget {
  const CompletedCallsList({
    super.key,
    required this.groups,
    required this.onTap,
  });

  final List<CompletedCallGroup> groups;
  final ValueChanged<CompletedCallItem> onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: groups.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, i) => _CompletedCallGroup(
        group: groups[i],
        onTap: onTap,
      ),
    );
  }
}

class _CompletedCallGroup extends StatelessWidget {
  const _CompletedCallGroup({required this.group, required this.onTap});

  final CompletedCallGroup group;
  final ValueChanged<CompletedCallItem> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            group.date,
            variant: AppTextVariant.label,
            color: AppColors.textMuted,
            align: TextAlign.start,
            weight: FontWeight.w600,
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: group.calls.length,
            separatorBuilder: (_, _) => const Divider(
              height: 24,
              thickness: 1,
              color: AppColors.border,
            ),
            itemBuilder: (_, i) => _CompletedCallRow(
              call: group.calls[i],
              onTap: () => onTap(group.calls[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompletedCallRow extends StatelessWidget {
  const _CompletedCallRow({required this.call, required this.onTap});

  final CompletedCallItem call;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isVideo = call.callType == CallType.video;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
      children: [
        ClipOval(
          child: call.avatarUrl != null
              ? Image.network(call.avatarUrl!, width: 40, height: 40, fit: BoxFit.cover)
              : Container(
                  width: 40,
                  height: 40,
                  color: AppColors.border,
                  child: const Icon(AppIcons.person, size: 20, color: AppColors.textMuted),
                ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppText(
                    call.name,
                    variant: AppTextVariant.body,
                    color: AppColors.textJet,
                    weight: FontWeight.w600,
                    align: TextAlign.start,
                  ),
                  const SizedBox(width: 8),
                  AppTag(
                    label: isVideo ? 'VIDEO' : 'AUDIO',
                    variant: AppTagVariant.solid,
                    color: isVideo ? const Color(0xFF489B08) : const Color(0xFF8F089B),
                    startIcon: Icon(
                      isVideo ? AppIcons.video : AppIcons.phone,
                      color: Colors.white,
                    ),
                    size: AppTagSize.small,
                  ),
                ],
              ),
              const SizedBox(height: 2),
              AppText(
                call.time,
                variant: AppTextVariant.label,
                color: AppColors.textMuted,
                align: TextAlign.start,
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AppText(
              call.amount,
              variant: AppTextVariant.body,
              color: AppColors.textJet,
              weight: FontWeight.w600,
              align: TextAlign.end,
            ),
            const SizedBox(height: 2),
            AppText(
              call.duration,
              variant: AppTextVariant.label,
              color: AppColors.textMuted,
              align: TextAlign.end,
            ),
          ],
        ),
      ],
      ),
    );
  }
}
