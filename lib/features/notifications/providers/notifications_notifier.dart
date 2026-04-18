import 'package:flutter/foundation.dart';

import 'package:ohlify/shared/services/services.dart';
import 'package:ohlify/shared/types/types.dart';

class NotificationsNotifier extends ChangeNotifier {
  NotificationsNotifier() : _items = [...MockService.getNotifications()];

  List<AppNotification> _items;

  List<AppNotification> get all => List.unmodifiable(_items);

  List<AppNotification> get unread =>
      _items.where((n) => !n.read).toList(growable: false);

  int get unreadCount => _items.where((n) => !n.read).length;

  bool get isEmpty => _items.isEmpty;

  void markAsRead(String id) {
    final idx = _items.indexWhere((n) => n.id == id);
    if (idx == -1 || _items[idx].read) return;
    _items[idx] = _items[idx].copyWith(read: true);
    _items = [..._items];
    notifyListeners();
  }

  void markAllAsRead() {
    if (unreadCount == 0) return;
    _items = _items.map((n) => n.copyWith(read: true)).toList();
    notifyListeners();
  }
}
