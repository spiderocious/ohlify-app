import 'package:ohlify/shared/types/scheduled_call_item.dart';

class CompletedCallGroup {
  const CompletedCallGroup({required this.date, required this.calls});

  final String date;
  final List<CompletedCallItem> calls;
}

class CompletedCallItem {
  const CompletedCallItem({
    required this.id,
    required this.name,
    required this.callType,
    required this.time,
    required this.duration,
    required this.amount,
    this.avatarUrl,
  });

  final String id;
  final String name;
  final CallType callType;
  final String time;
  final String duration;
  final String amount;
  final String? avatarUrl;
}
