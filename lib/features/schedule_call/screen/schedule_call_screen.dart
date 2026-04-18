import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/features/schedule_call/screen/parts/details_modal_content.dart';
import 'package:ohlify/features/schedule_call/screen/parts/rates_modal_content.dart';
import 'package:ohlify/features/schedule_call/screen/parts/schedule_call_form.dart';
import 'package:ohlify/features/schedule_call/screen/parts/schedule_call_header.dart';
import 'package:ohlify/features/schedule_call/screen/parts/schedule_call_interests.dart';
import 'package:ohlify/features/schedule_call/screen/parts/schedule_call_tabs.dart';
import 'package:ohlify/shared/notifiers/modal_notifier.dart';
import 'package:ohlify/shared/services/services.dart';
import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/theme/app_colors.dart';

class ScheduleCallScreen extends StatelessWidget {
  const ScheduleCallScreen({super.key, required this.professionalId});

  final String professionalId;

  // Hardcoded mock interests — swap for professional-driven data when wired.
  static const _interests = ['Relationship', 'Technology', 'Entertainment'];

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

    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ScheduleCallHeader(professional: professional),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ScheduleCallActions(
                onDetails: () => _openDetails(professional.id),
                onRates: () => _openRates(professional.id),
                onVideo: () {},
                onAudio: () {},
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ScheduleCallInterests(interests: _interests),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ScheduleCallForm(onSchedule: (_) => context.pop()),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _openDetails(String id) {
    final details = MockService.getProfessionalDetails(id);
    DrawerService.instance.showCustomModal(
      'Details',
      (_, _) => DetailsModalContent(details: details),
      options: const CustomModalOptions(position: ModalPosition.bottom),
    );
  }

  void _openRates(String id) {
    final rates = MockService.getProfessionalRates(id);
    DrawerService.instance.showCustomModal(
      'Rates',
      (_, _) => RatesModalContent(rates: rates),
      options: const CustomModalOptions(
        position: ModalPosition.bottom
      ),
    );
  }

  Professional? _findProfessional(String id) {
    for (final p in MockService.getProfessionals()) {
      if (p.id == id) return p;
    }
    // Fallback: treat upcoming call entries as professionals
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
