import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:ohlify/features/notifications/providers/notifications_notifier.dart';
import 'package:ohlify/features/notifications/providers/notifications_provider.dart';
import 'package:ohlify/features/notifications/screen/parts/notification_tile.dart';
import 'package:ohlify/features/notifications/screen/parts/notifications_empty_state.dart';
import 'package:ohlify/features/notifications/screen/parts/notifications_tabs.dart';
import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const NotificationsProvider(child: _NotificationsContent());
  }
}

class _NotificationsContent extends StatefulWidget {
  const _NotificationsContent();

  @override
  State<_NotificationsContent> createState() => _NotificationsContentState();
}

class _NotificationsContentState extends State<_NotificationsContent> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<NotificationsNotifier>();
    final items =
        _tab == 0 ? notifier.all : notifier.unread;
    final canMarkAll = notifier.unreadCount > 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    behavior: HitTestBehavior.opaque,
                    child: const Row(
                      children: [
                        Icon(
                          AppIcons.chevronLeft,
                          size: 22,
                          color: AppColors.textJet,
                        ),
                        SizedBox(width: 4),
                        AppText(
                          'Home',
                          variant: AppTextVariant.body,
                          color: AppColors.textJet,
                          weight: FontWeight.w500,
                          align: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  _MarkAllButton(
                    enabled: canMarkAll,
                    onPressed: notifier.markAllAsRead,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  'Notifications',
                  variant: AppTextVariant.title,
                  color: AppColors.textJet,
                  weight: FontWeight.w800,
                  align: TextAlign.start,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: NotificationsTabs(
                activeIndex: _tab,
                unreadCount: notifier.unreadCount,
                allCount: notifier.all.length,
                onTap: (i) => setState(() => _tab = i),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: items.isEmpty
                  ? const Center(child: NotificationsEmptyState())
                  : _buildList(items, notifier),
            ),
          ],
        ),
      ),
    );
  }

  static const _tabRoots = {
    AppRoutes.home,
    AppRoutes.calls,
    AppRoutes.wallet,
    AppRoutes.profile,
  };

  void _onTapNotification(
    AppNotification n,
    NotificationsNotifier notifier,
  ) {
    notifier.markAsRead(n.id);
    final route = n.route;
    if (route == null) return;
    // Tab-root routes must switch branches, so use `go`; deep routes push
    // onto the current stack.
    if (_tabRoots.contains(route)) {
      context.go(route);
    } else {
      context.push(route);
    }
  }

  Widget _buildList(
    List<AppNotification> items,
    NotificationsNotifier notifier,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: items.length,
      separatorBuilder: (_, _) => const Divider(
        height: 1,
        thickness: 1,
        color: AppColors.border,
      ),
      itemBuilder: (_, i) => NotificationTile(
        notification: items[i],
        onTap: () => _onTapNotification(items[i], notifier),
      ),
    );
  }
}

class _MarkAllButton extends StatelessWidget {
  const _MarkAllButton({required this.enabled, required this.onPressed});

  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final color = enabled ? AppColors.post : AppColors.textDisabled;
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: enabled ? color : AppColors.border,
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              'Mark all as read',
              variant: AppTextVariant.bodyNormal,
              color: color,
              weight: FontWeight.w600,
              align: TextAlign.center,
            ),
            const SizedBox(width: 6),
            Icon(Icons.done_all_rounded, size: 16, color: color),
          ],
        ),
      ),
    );
  }
}
