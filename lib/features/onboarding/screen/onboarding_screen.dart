import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/features/onboarding/screen/parts/onboarding_slide.dart';
import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';

const _slides = [
  OnboardingSlideData(
    title: 'Get Paid for Calls',
    subtitle: 'Set your rate. Share your link. Get paid per minute.',
  ),
  OnboardingSlideData(
    title: 'Connect with other experts',
    subtitle:
        'Connect with top-tier professionals across industries. Skip the back and forth emails and book a session',
  ),
  OnboardingSlideData(
    title: 'Ready to level up',
    subtitle:
        'Set up your profile in seconds and find the perfect mentor, consultant or specialist to help you reach your goals',
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  late Timer _autoScrollTimer;
  int _currentPage = 0;
  bool _userScrolling = false;

  static const _autoScrollInterval = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(_autoScrollInterval, (_) {
      if (_userScrolling || !mounted) return;
      final next = (_currentPage + 1) % _slides.length;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  void _onPageChanged(int page) {
    setState(() => _currentPage = page);
  }

  @override
  void dispose() {
    _autoScrollTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.componentPreview),
        tooltip: 'Component Preview',
        child: const Icon(AppIcons.components),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ── Slide indicator ───────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: _SlideIndicator(
                count: _slides.length,
                current: _currentPage,
              ),
            ),

            // ── Scrollable slide area ─────────────────────────────────
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollStartNotification &&
                      notification.dragDetails != null) {
                    // User initiated drag — pause auto scroll
                    setState(() => _userScrolling = true);
                  } else if (notification is ScrollEndNotification) {
                    // Resume auto scroll after user lifts finger
                    setState(() => _userScrolling = false);
                  }
                  return false;
                },
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: _slides.length,
                  itemBuilder: (_, i) => OnboardingSlide(data: _slides[i]),
                ),
              ),
            ),

            // ── Static buttons ────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              child: Column(
                children: [
                  AppButton(
                    label: 'Get started',
                    onPressed: () => context.push(AppRoutes.register),
                    expanded: true,
                    radius: 100,
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    label: 'Login',
                    onPressed: () => context.push(AppRoutes.login),
                    variant: AppButtonVariant.outline,
                    expanded: true,
                    radius: 100,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlideIndicator extends StatelessWidget {
  const _SlideIndicator({required this.count, required this.current});

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(count, (i) {
        final isActive = i == current;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i < count - 1 ? 6 : 0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 4,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : AppColors.secondary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        );
      }),
    );
  }
}
