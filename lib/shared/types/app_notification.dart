enum AppNotificationKind { missedCall, upcomingCall, paymentReceived, system }

class AppNotification {
  const AppNotification({
    required this.id,
    required this.kind,
    required this.title,
    required this.message,
    required this.timeLabel,
    required this.read,
    this.route,
  });

  final String id;
  final AppNotificationKind kind;
  final String title;
  final String message;

  /// Display-formatted timestamp, e.g. 'Today', '3 hours ago', '21 Feb. 2024'.
  final String timeLabel;
  final bool read;

  /// Absolute route to navigate to when the notification is tapped. When
  /// null, tapping only marks the notification as read. When set the row
  /// also shows a trailing chevron.
  final String? route;

  bool get navigatesToDetail => route != null;

  AppNotification copyWith({bool? read}) {
    return AppNotification(
      id: id,
      kind: kind,
      title: title,
      message: message,
      timeLabel: timeLabel,
      read: read ?? this.read,
      route: route,
    );
  }
}
