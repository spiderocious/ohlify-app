import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/features/home/screen/parts/category_filter.dart';
import 'package:ohlify/features/home/screen/parts/popular_professionals_list.dart';
import 'package:ohlify/features/home/screen/parts/upcoming_call_banner.dart';
import 'package:ohlify/features/home/screen/parts/upcoming_calls_list.dart';
import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/shared/services/services.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_search_bar/app_search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheduledCall = MockService.getScheduledCall();
    final upcomingCalls = MockService.getUpcomingCalls();
    final categories = MockService.getCategories();
    final professionals = MockService.getProfessionals();

    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              AppSearchBar(
                readOnly: true,
                onTap: () =>
                    context.push('${AppRoutes.professionals}?focus=1'),
              ),
              if (scheduledCall != null) ...[
                const SizedBox(height: 16),
                UpcomingCallBanner(
                  calleeName: scheduledCall.calleeName,
                  scheduledTime: scheduledCall.scheduledTime,
                  onJoin: () {},
                ),
              ],
              const SizedBox(height: 24),
              UpcomingCallsList(
                calls: upcomingCalls,
                onViewAll: () => context.go(AppRoutes.calls),
                onTap: (call) => context.push('${AppRoutes.call}/${call.id}'),
              ),
              const SizedBox(height: 24),
              CategoryFilter(
                categories: categories,
                onChanged: (_) {},
              ),
              const SizedBox(height: 24),
              PopularProfessionalsList(
                professionals: professionals,
                onViewAll: () => context.push(AppRoutes.professionals),
                onSchedule: (pro) => context.push('${AppRoutes.scheduleCall}/${pro.id}'),
                onTap: (pro) => context.push('${AppRoutes.professional}/${pro.id}'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
