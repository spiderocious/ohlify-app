class ScheduledCall {
  const ScheduledCall({
    required this.id,
    required this.calleeName,
    required this.scheduledTime,
    this.avatarUrl,
  });

  final String id;
  final String calleeName;

  /// Human-readable time-until string, e.g. "5 mins", "2 hours".
  final String scheduledTime;
  final String? avatarUrl;
}
