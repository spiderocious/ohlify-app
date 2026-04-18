import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/features/call_details/screen/parts/call_action_buttons.dart';
import 'package:ohlify/features/call_details/screen/parts/call_history_section.dart';
import 'package:ohlify/features/call_details/screen/parts/call_info_card.dart';
import 'package:ohlify/features/call_details/screen/parts/call_participant_header.dart';
import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/shared/services/services.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_icon_button/app_icon_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class CallDetailsScreen extends StatelessWidget {
  const CallDetailsScreen({super.key, required this.callId});

  final String callId;

  @override
  Widget build(BuildContext context) {
    final call = MockService.getCallById(callId);

    if (call == null) {
      return Scaffold(
        backgroundColor: AppColors.surfaceLight,
        body: Center(
          child: TextButton(
            onPressed: () => context.pop(),
            child: const Text('Call not found'),
          ),
        ),
      );
    }

    final history = MockService.getCallHistoryWithProfessional(
      call.professionalId,
    );

    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  AppIconButton(
                    icon: const Icon(AppIcons.back, color: AppColors.textJet),
                    variant: AppIconButtonVariant.ghost,
                    backgroundColor: AppColors.background,
                    size: 44,
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(width: 12),
                  const AppText(
                    'Call details',
                    variant: AppTextVariant.header,
                    color: AppColors.textJet,
                    weight: FontWeight.w700,
                    align: TextAlign.start,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CallParticipantHeader(call: call),
                    const SizedBox(height: 16),
                    CallInfoCard(call: call),
                    const SizedBox(height: 20),
                    CallHistorySection(history: history),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: CallActionButtons(
                call: call,
                onJoin: () {},
                onReschedule: () => context
                    .push('${AppRoutes.scheduleCall}/${call.professionalId}'),
                onScheduleAnother: () => context
                    .push('${AppRoutes.scheduleCall}/${call.professionalId}'),
                onViewProfile: () => context
                    .push('${AppRoutes.professional}/${call.professionalId}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
