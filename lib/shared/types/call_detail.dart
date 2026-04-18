import 'package:ohlify/shared/types/scheduled_call_item.dart';

enum CallStatus { upcoming, completed, missed }

class CallDetail {
  const CallDetail({
    required this.id,
    required this.professionalId,
    required this.name,
    required this.role,
    required this.rating,
    required this.callType,
    required this.status,
    required this.time,
    required this.date,
    required this.duration,
    required this.canJoin,
    required this.canReschedule,
    this.amount,
    this.avatarUrl,
  });

  final String id;
  final String professionalId;
  final String name;
  final String role;
  final double rating;
  final CallType callType;
  final CallStatus status;

  /// Display-formatted time, e.g. '12:00 PM'.
  final String time;

  /// Display-formatted date, e.g. '23 Feb, 2026'.
  final String date;
  final String duration;

  /// True when the call is scheduled and it's within the join window.
  final bool canJoin;

  /// True when a scheduled call can still be rescheduled by the user.
  final bool canReschedule;

  /// Only populated for completed calls, e.g. '₦20,000.00'.
  final String? amount;
  final String? avatarUrl;
}
