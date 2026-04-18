import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.bullets,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final List<String> bullets;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: selected ? AppColors.surfaceDark : AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary : AppColors.surfaceDark,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    size: 22,
                    color: selected ? Colors.white : AppColors.primary,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: AppText(
                    title,
                    variant: AppTextVariant.medium,
                    color: AppColors.textJet,
                    weight: FontWeight.w700,
                    align: TextAlign.start,
                  ),
                ),
                _Radio(selected: selected),
              ],
            ),
            const SizedBox(height: 12),
            AppText(
              subtitle,
              variant: AppTextVariant.body,
              color: AppColors.textMuted,
              align: TextAlign.start,
            ),
            const SizedBox(height: 14),
            for (int i = 0; i < bullets.length; i++) ...[
              if (i > 0) const SizedBox(height: 8),
              _Bullet(text: bullets[i]),
            ],
          ],
        ),
      ),
    );
  }
}

class _Radio extends StatelessWidget {
  const _Radio({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? AppColors.primary : Colors.transparent,
        border: Border.all(
          color: selected ? AppColors.primary : AppColors.border,
          width: 2,
        ),
      ),
      child: selected
          ? const Icon(Icons.check, size: 14, color: Colors.white)
          : null,
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 6),
          child: Icon(Icons.check_circle, size: 14, color: AppColors.primary),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: AppText(
            text,
            variant: AppTextVariant.body,
            color: AppColors.textCharcoal,
            align: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
