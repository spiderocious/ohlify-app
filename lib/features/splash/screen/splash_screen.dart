import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/ui/icons/app_icons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (mounted) context.go(AppRoutes.onboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/common/splash-screen.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: Image.asset(
              'assets/logos/logo-with-text-white.png',
              width: 160,
            ),
          ),
          // Dev shortcut — component preview FAB
          Positioned(
            bottom: 32,
            right: 20,
            child: FloatingActionButton(
              onPressed: () => context.push(AppRoutes.componentPreview),
              tooltip: 'Component Preview',
              child: const Icon(AppIcons.components),
            ),
          ),
        ],
      ),
    );
  }
}
