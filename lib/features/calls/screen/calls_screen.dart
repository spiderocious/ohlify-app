import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/features/calls/screen/parts/call_stats_summary.dart';
import 'package:ohlify/features/calls/screen/parts/completed_calls_list.dart';
import 'package:ohlify/features/calls/screen/parts/scheduled_calls_list.dart';
import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/shared/services/services.dart';
import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_tab_view/app_tab_view.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  static const _selfId = 'me';

  @override
  Widget build(BuildContext context) {
    final stats = MockService.getCallStats();
    final scheduledCalls = MockService.getScheduledCalls();
    final completedCalls = MockService.getCompletedCalls();

    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      floatingActionButton: const _DevIncomingFab(selfId: _selfId),
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
                      onJoin: (call) => _joinCall(context, call),
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

  void _joinCall(BuildContext context, ScheduledCallItem call) {
    final kind = call.callType == CallType.video ? 'video' : 'audio';
    context.push(
      '${AppRoutes.callSessionBase}/caller/$kind/$_selfId/${call.id}/${call.id}'
      '?name=${Uri.encodeComponent(call.name)}'
      '${call.avatarUrl != null ? '&avatar=${Uri.encodeComponent(call.avatarUrl!)}' : ''}',
    );
  }
}

/// Dev-only: long-press to simulate an incoming audio call; tap for a video
/// one. Gives us a way to exercise the callee flow on a single device.
class _DevIncomingFab extends StatelessWidget {
  const _DevIncomingFab({required this.selfId});

  final String selfId;

  void _simulate(BuildContext context, CallType kind) {
    final peer = MockService.getProfessionals().first;
    final kindSlug = kind == CallType.video ? 'video' : 'audio';
    final sessionId = 'incoming-${DateTime.now().millisecondsSinceEpoch}';
    context.push(
      '${AppRoutes.callSessionBase}/callee/$kindSlug/$selfId/${peer.id}/$sessionId'
      '?name=${Uri.encodeComponent(peer.name)}'
      '${peer.avatarUrl != null ? '&avatar=${Uri.encodeComponent(peer.avatarUrl!)}' : ''}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _simulate(context, CallType.audio),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      icon: const Icon(Icons.call_received_rounded),
      label: GestureDetector(
        onLongPress: () => _simulate(context, CallType.video),
        child: const Text(
          'Simulate incoming',
          style: TextStyle(
            fontFamily: 'MonaSans',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
