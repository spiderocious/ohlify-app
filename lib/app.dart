import 'package:flutter/material.dart';

import 'package:ohlify/app_router.dart';
import 'package:ohlify/ui/theme/app_theme.dart';
import 'package:ohlify/ui/widgets/modal_overlay/modal_overlay.dart';
import 'package:ohlify/ui/widgets/toast_overlay/toast_overlay.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ohlifyssss',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: appRouter,
      builder: (context, child) => ToastOverlay(
        child: ModalOverlay(child: child ?? const SizedBox()),
      ),
    );
  }
}
