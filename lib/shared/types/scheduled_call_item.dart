enum CallType { video, audio }

class ScheduledCallItem {
  const ScheduledCallItem({
    required this.id,
    required this.name,
    required this.role,
    required this.rating,
    required this.callType,
    required this.time,
    required this.date,
    required this.duration,
    required this.canReschedule,
    this.avatarUrl,
  });

  final String id;
  final String name;
  final String role;
  final double rating;
  final CallType callType;
  final String time;
  final String date;
  final String duration;

  /// When true shows Cancel + Reschedule buttons.
  /// When false shows Join call button.
  final bool canReschedule;
  final String? avatarUrl;
}
