import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/ui/widgets/app_bottom_nav_bar/app_bottom_nav_bar.dart';
import 'package:ohlify/ui/widgets/app_header/app_header.dart';

/// The persistent shell wrapping all main tab screens.
///
/// [showHeader] controls whether the top [AppHeader] is rendered.
class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.navigationShell,
    this.showHeader = true,
  });

  final StatefulNavigationShell navigationShell;
  final bool showHeader;

  @override
  Widget build(BuildContext context) {
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
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}
