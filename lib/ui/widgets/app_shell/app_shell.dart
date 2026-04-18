import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/ui/widgets/app_bottom_nav_bar/app_bottom_nav_bar.dart';
import 'package:ohlify/ui/widgets/app_header/app_header.dart';

/// The persistent shell wrapping all main tab screens.
///
/// The active tab is derived from the current route rather than
/// [StatefulNavigationShell.currentIndex] so that a `push`/`go` to a
/// tab route (e.g. from within Home to `/calls`) still lights up the
/// correct nav item.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _tabRoots = [
    AppRoutes.home,
    AppRoutes.calls,
    AppRoutes.wallet,
    AppRoutes.profile,
  ];

  int _indexForLocation(String location) {
    for (var i = 0; i < _tabRoots.length; i++) {
      final root = _tabRoots[i];
      if (location == root || location.startsWith('$root/')) return i;
    }
    return navigationShell.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final activeIndex = _indexForLocation(location);
    final showHeader = activeIndex == 0;

    return Scaffold(
      appBar: showHeader
          ? PreferredSize(
              preferredSize: const Size.fromHeight(64),
              child: SafeArea(
                bottom: false,
                child: AppHeader(
                  notificationCount: 1,
                  onCopyLink: () {},
                  onNotification: () {},
                ),
              ),
            )
          : null,
      body: navigationShell,
      bottomNavigationBar: AppBottomNavBar(
        items: appMainNavItems,
        currentIndex: activeIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == activeIndex,
        ),
      ),
    );
  }
}
