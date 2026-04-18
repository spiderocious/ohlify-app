import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/features/professional_details/screen/parts/description_section.dart';
import 'package:ohlify/features/professional_details/screen/parts/rates_section.dart';
import 'package:ohlify/features/professional_details/screen/parts/reviews_section.dart';
import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/shared/services/services.dart';
import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/professional_header/professional_header.dart';

class ProfessionalDetailsScreen extends StatelessWidget {
  const ProfessionalDetailsScreen({super.key, required this.professionalId});

  final String professionalId;

  @override
  Widget build(BuildContext context) {
    final professional = _findProfessional(professionalId);

    if (professional == null) {
      return Scaffold(
        backgroundColor: AppColors.surfaceLight,
        body: Center(
          child: TextButton(
            onPressed: () => context.pop(),
            child: const Text('Professional not found'),
          ),
        ),
      );
    }

    final description = MockService.getProfessionalDetails(professional.id);
    final rates = MockService.getProfessionalRates(professional.id);
    final reviews = MockService.getProfessionalReviews(professional.id);

    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfessionalHeader(professional: professional),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DescriptionSection(description: description),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RatesSection(rates: rates),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ReviewsSection(reviews: reviews),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: AppButton(
            label: 'Schedule call',
            onPressed: () =>
                context.push('${AppRoutes.scheduleCall}/${professional.id}'),
            radius: 100,
            height: 52,
          ),
        ),
      ),
    );
  }

  Professional? _findProfessional(String id) {
    for (final p in MockService.getProfessionals()) {
      if (p.id == id) return p;
    }
    for (final c in MockService.getUpcomingCalls()) {
      if (c.id == id) {
        return Professional(
          id: c.id,
          name: c.name,
          role: c.role,
          rating: c.rating,
          reviewCount: c.reviewCount,
          avatarUrl: c.avatarUrl,
        );
      }
    }
    return null;
  }
}
