import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/features/calls/screen/parts/call_stats_summary.dart';
import 'package:ohlify/features/calls/screen/parts/completed_calls_list.dart';
import 'package:ohlify/features/calls/screen/parts/scheduled_calls_list.dart';
import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/shared/services/services.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_tab_view/app_tab_view.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = MockService.getCallStats();
    final scheduledCalls = MockService.getScheduledCalls();
    final completedCalls = MockService.getCompletedCalls();

    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              const AppText(
                'Calls',
                variant: AppTextVariant.title,
                color: AppColors.textJet,
                align: TextAlign.start,
                weight: FontWeight.w800,
              ),
              const SizedBox(height: 16),
              CallStatsSummary(stats: stats),
              const SizedBox(height: 24),
              AppTabView(
                tabs: [
                  AppTabItem(
                    label: 'Scheduled calls',
                    child: ScheduledCallsList(
                      calls: scheduledCalls,
                      onCancel: (_) {},
                      onReschedule: (_) {},
                      onJoin: (_) {},
                      onTap: (call) =>
                          context.push('${AppRoutes.call}/${call.id}'),
                    ),
                  ),
                  AppTabItem(
                    label: 'Completed calls',
                    child: CompletedCallsList(
                      groups: completedCalls,
                      onTap: (call) =>
                          context.push('${AppRoutes.call}/${call.id}'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
