import 'package:flutter/material.dart';

import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_date_input/app_date_input.dart';
import 'package:ohlify/ui/widgets/app_dropdown_input/app_dropdown_input.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/app_text_input/app_text_input.dart';

class ScheduleCallForm extends StatefulWidget {
  const ScheduleCallForm({super.key, required this.onSchedule});

  final ValueChanged<ScheduleCallFormData> onSchedule;

  @override
  State<ScheduleCallForm> createState() => _ScheduleCallFormState();
}

class ScheduleCallFormData {
  const ScheduleCallFormData({
    required this.date,
    required this.callType,
    required this.durationMinutes,
    required this.time,
  });

  final DateTime date;
  final CallType callType;
  final int durationMinutes;
  final String time;
}

class _ScheduleCallFormState extends State<ScheduleCallForm> {
  DateTime? _date;
  CallType? _callType;
  int? _duration;
  final _timeController = TextEditingController();

  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }

  bool get _isValid =>
      _date != null &&
      _callType != null &&
      _duration != null &&
      _timeController.text.trim().isNotEmpty;

  void _submit() {
    if (!_isValid) return;
    widget.onSchedule(
      ScheduleCallFormData(
        date: _date!,
        callType: _callType!,
        durationMinutes: _duration!,
        time: _timeController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppDateInput(
            label: 'Select date',
            value: _date,
            onChanged: (d) => setState(() => _date = d),
          ),
          const SizedBox(height: 20),
          const _FieldLabel('Call type'),
          const SizedBox(height: 8),
          AppDropdownInput<CallType>(
            placeholder: 'Audio',
            bordered: true,
            value: _callType,
            options: const [
              DropdownOption(label: 'Audio', value: CallType.audio),
              DropdownOption(label: 'Video', value: CallType.video),
            ],
            onChanged: (v) => setState(() => _callType = v),
          ),
          const SizedBox(height: 20),
          const _FieldLabel('Duration'),
          const SizedBox(height: 8),
          AppDropdownInput<int>(
            placeholder: '20 minutes',
            bordered: true,
            value: _duration,
            options: const [
              DropdownOption(label: '10 minutes', value: 10),
              DropdownOption(label: '20 minutes', value: 20),
              DropdownOption(label: '30 minutes', value: 30),
            ],
            onChanged: (v) => setState(() => _duration = v),
          ),
          const SizedBox(height: 20),
          const _FieldLabel('Time'),
          const SizedBox(height: 8),
          AppTextInput(
            controller: _timeController,
            placeholder: '12:09AM',
            keyboardType: TextInputType.datetime,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 24),
          AppButton(
            label: 'Schedule call',
            expanded: true,
            radius: 100,
            height: 52,
            isDisabled: !_isValid,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      variant: AppTextVariant.body,
      color: AppColors.textJet,
      weight: FontWeight.w600,
      align: TextAlign.start,
    );
  }
}

