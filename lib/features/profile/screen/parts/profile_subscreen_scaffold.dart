import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

/// Standard chrome for every profile sub-screen: Back row, bold title,
/// and a scrollable body with optional bottom-pinned content.
class ProfileSubscreenScaffold extends StatelessWidget {
  const ProfileSubscreenScaffold({
    super.key,
    required this.title,
    required this.body,
    this.bottom,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
    this.backgroundColor = AppColors.background,
  });

  final String title;
  final Widget body;
  final Widget? bottom;
  final EdgeInsets padding;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    behavior: HitTestBehavior.opaque,
                    child: const Row(
                      children: [
                        Icon(
                          AppIcons.chevronLeft,
                          size: 22,
                          color: AppColors.textJet,
                        ),
                        SizedBox(width: 4),
                        AppText(
                          'Back',
                          variant: AppTextVariant.body,
                          color: AppColors.textJet,
                          weight: FontWeight.w500,
                          align: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(padding.left, 4, padding.right, 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  title,
                  variant: AppTextVariant.title,
                  color: AppColors.textJet,
                  weight: FontWeight.w800,
                  align: TextAlign.start,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  padding.left,
                  0,
                  padding.right,
                  bottom == null ? 24 : 16,
                ),
                child: body,
              ),
            ),
            if (bottom != null)
              Padding(
                padding: EdgeInsets.fromLTRB(
                  padding.left,
                  8,
                  padding.right,
                  16,
                ),
                child: bottom,
              ),
          ],
        ),
      ),
    );
  }
}
