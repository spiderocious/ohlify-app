import 'package:flutter/material.dart';

import 'package:ohlify/features/profile/screen/parts/profile_subscreen_scaffold.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class LegalDocumentSection {
  const LegalDocumentSection({required this.heading, required this.body});
  final String heading;
  final String body;
}

/// Generic renderer for privacy policy / EULA / T&C screens.
class LegalDocumentScreen extends StatelessWidget {
  const LegalDocumentScreen({
    super.key,
    required this.title,
    required this.effectiveLine,
    required this.sections,
  });

  final String title;

  /// First small line, e.g. "Effective Date: January 1, 2026".
  final String effectiveLine;

  final List<LegalDocumentSection> sections;

  @override
  Widget build(BuildContext context) {
    return ProfileSubscreenScaffold(
      title: title,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppText(
            effectiveLine,
            variant: AppTextVariant.body,
            color: AppColors.textJet,
            weight: FontWeight.w700,
            align: TextAlign.start,
          ),
          const SizedBox(height: 14),
          for (int i = 0; i < sections.length; i++) ...[
            if (i > 0) const SizedBox(height: 16),
            AppText(
              sections[i].heading,
              variant: AppTextVariant.body,
              color: AppColors.textJet,
              weight: FontWeight.w700,
              align: TextAlign.start,
            ),
            const SizedBox(height: 6),
            AppText(
              sections[i].body,
              variant: AppTextVariant.body,
              color: AppColors.textCharcoal,
              align: TextAlign.start,
            ),
          ],
        ],
      ),
    );
  }
}
