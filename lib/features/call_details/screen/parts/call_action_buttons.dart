import 'package:flutter/material.dart';

import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';

class CallActionButtons extends StatelessWidget {
  const CallActionButtons({
    super.key,
    required this.call,
    required this.onJoin,
    required this.onReschedule,
    required this.onScheduleAnother,
    required this.onViewProfile,
  });

  final CallDetail call;
  final VoidCallback onJoin;
  final VoidCallback onReschedule;
  final VoidCallback onScheduleAnother;
  final VoidCallback onViewProfile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ..._primaryButtons(),
        const SizedBox(height: 10),
        AppButton(
          label: 'View full profile',
          variant: AppButtonVariant.outline,
          onPressed: onViewProfile,
          radius: 100,
          height: 52,
        ),
      ],
    );
  }

  List<Widget> _primaryButtons() {
    return switch (call.status) {
      CallStatus.upcoming when call.canJoin => [
        AppButton(
          label: 'Join call',
          onPressed: onJoin,
          radius: 100,
          height: 52,
        ),
      ],
      CallStatus.upcoming when call.canReschedule => [
        AppButton(
          label: 'Reschedule',
          onPressed: onReschedule,
          radius: 100,
          height: 52,
        ),
        const SizedBox(height: 10),
        AppButton(
          label: 'Schedule another call',
          variant: AppButtonVariant.plain,
          onPressed: onScheduleAnother,
          radius: 100,
          height: 52,
        ),
      ],
      CallStatus.upcoming => [
        AppButton(
          label: 'Schedule another call',
          onPressed: onScheduleAnother,
          radius: 100,
          height: 52,
        ),
      ],
      CallStatus.completed || CallStatus.missed => [
        AppButton(
          label: 'Schedule another call',
          onPressed: onScheduleAnother,
          radius: 100,
          height: 52,
        ),
      ],
    };
  }
}
