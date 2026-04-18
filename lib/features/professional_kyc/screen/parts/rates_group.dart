import 'package:flutter/material.dart';

import 'package:ohlify/features/professional_kyc/types/kyc_rate.dart';
import 'package:ohlify/shared/types/scheduled_call_item.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_icon_button/app_icon_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class RatesGroup extends StatelessWidget {
  const RatesGroup({
    super.key,
    required this.callType,
    required this.rates,
    required this.onDelete,
  });

  final CallType callType;
  final List<KycRate> rates;
  final ValueChanged<KycRate> onDelete;

  String get _title =>
      callType == CallType.audio ? 'Audio call' : 'Video call';

  Color get _accent => callType == CallType.audio
      ? const Color(0xFFE8F5E9)
      : AppColors.background;

  Color get _iconColor => callType == CallType.audio
      ? const Color(0xFF1F6F15)
      : AppColors.textJet;

  Color get _textColor => callType == CallType.audio
      ? const Color(0xFF1F6F15)
      : AppColors.textJet;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          _title,
          variant: AppTextVariant.body,
          color: AppColors.textMuted,
          align: TextAlign.start,
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: _accent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Column(
            children: [
              for (int i = 0; i < rates.length; i++) ...[
                if (i > 0)
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.border,
                  ),
                _Row(
                  rate: rates[i],
                  textColor: _textColor,
                  iconColor: _iconColor,
                  onDelete: () => onDelete(rates[i]),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.rate,
    required this.textColor,
    required this.iconColor,
    required this.onDelete,
  });

  final KycRate rate;
  final Color textColor;
  final Color iconColor;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
      child: Row(
        children: [
          Icon(Icons.access_time_rounded, size: 20, color: iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: AppText(
              '${rate.durationMinutes} minutes',
              variant: AppTextVariant.body,
              color: textColor,
              weight: FontWeight.w500,
              align: TextAlign.start,
            ),
          ),
          AppText(
            rate.price,
            variant: AppTextVariant.body,
            color: textColor,
            weight: FontWeight.w600,
            align: TextAlign.end,
          ),
          const SizedBox(width: 10),
          AppIconButton(
            icon: const Icon(AppIcons.delete, color: AppColors.danger),
            shape: AppIconButtonShape.squircle,
            backgroundColor: const Color(0xFFFDECEA),
            size: 36,
            iconSize: 18,
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
