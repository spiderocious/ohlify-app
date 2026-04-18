import 'package:flutter/material.dart';

import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_tag/app_tag.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/professional_rating/professional_rating.dart';

class CallParticipantHeader extends StatelessWidget {
  const CallParticipantHeader({super.key, required this.call});

  final CallDetail call;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Avatar(url: call.avatarUrl),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      call.name,
                      variant: AppTextVariant.header,
                      color: AppColors.textJet,
                      weight: FontWeight.w700,
                      align: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    AppText(
                      call.role,
                      variant: AppTextVariant.body,
                      color: AppColors.textMuted,
                      align: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    ProfessionalRating(
                      rating: call.rating,
                      reviewCount: 0,
                      showDivider: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _StatusTag(status: call.status),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({this.url});
  final String? url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 72,
        height: 72,
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
      child: const Icon(AppIcons.person, size: 32, color: AppColors.textMuted),
    );
  }
}

class _StatusTag extends StatelessWidget {
  const _StatusTag({required this.status});

  final CallStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      CallStatus.upcoming => ('UPCOMING', AppColors.primary),
      CallStatus.completed => ('COMPLETED', AppColors.success),
      CallStatus.missed => ('MISSED', AppColors.danger),
    };

    return AppTag(
      label: label,
      variant: AppTagVariant.solid,
      color: color,
      size: AppTagSize.small,
    );
  }
}
