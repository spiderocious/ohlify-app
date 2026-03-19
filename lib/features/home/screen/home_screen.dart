import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_banner/app_banner.dart';
import 'package:ohlify/ui/widgets/app_search_bar/app_search_bar.dart';
import 'package:ohlify/ui/widgets/category_filter_bar/category_filter_bar.dart';
import 'package:ohlify/ui/widgets/professional_list_tile/professional_list_tile.dart';
import 'package:ohlify/ui/widgets/section_header/section_header.dart';
import 'package:ohlify/ui/widgets/upcoming_call_card/upcoming_call_card.dart';

// ---------------------------------------------------------------------------
// Mock data
// ---------------------------------------------------------------------------

const _upcomingCalls = [
  _CallData(
    name: 'Dr. Sarah Lim',
    role: 'Financial Advisor',
    rating: 4.9,
    reviewCount: 120,
  ),
  _CallData(
    name: 'James Okafor',
    role: 'Career Coach',
    rating: 4.7,
    reviewCount: 84,
  ),
  _CallData(
    name: 'Amaka Nweze',
    role: 'Business Mentor',
    rating: 4.8,
    reviewCount: 67,
  ),
];

const _categories = [
  'All',
  'Finance',
  'Career',
  'Business',
  'Health',
  'Legal',
];

const _professionals = [
  _ProfData(
    name: 'Dr. Sarah Lim',
    role: 'Financial Advisor',
    rating: 4.9,
    reviewCount: 120,
  ),
  _ProfData(
    name: 'James Okafor',
    role: 'Career Coach',
    rating: 4.7,
    reviewCount: 84,
  ),
  _ProfData(
    name: 'Amaka Nweze',
    role: 'Business Mentor',
    rating: 4.8,
    reviewCount: 67,
  ),
  _ProfData(
    name: 'Tunde Adeyemi',
    role: 'Legal Consultant',
    rating: 4.6,
    reviewCount: 55,
  ),
  _ProfData(
    name: 'Dr. Ifeoma Eze',
    role: 'Health Coach',
    rating: 4.9,
    reviewCount: 200,
  ),
];

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Welcome banner
              AppBanner(
                variant: AppBannerVariant.primary,
                rounded: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Good morning! 👋',
                        style: TextStyle(
                          fontFamily: 'MonaSans',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Find the right professional for your needs.',
                        style: TextStyle(
                          fontFamily: 'MonaSans',
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Search bar
              AppSearchBar(
                readOnly: true,
                onTap: () {},
              ),
              const SizedBox(height: 24),

              // Upcoming calls section
              SectionHeader(
                title: 'Upcoming Calls',
                onViewAll: () => context.go(AppRoutes.calls),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 224,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  itemCount: _upcomingCalls.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final call = _upcomingCalls[index];
                    return UpcomingCallCard(
                      name: call.name,
                      role: call.role,
                      rating: call.rating,
                      reviewCount: call.reviewCount,
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Category filter
              const SectionHeader(title: 'Categories'),
              const SizedBox(height: 14),
              CategoryFilterBar(
                categories: _categories,
                selected: _selectedCategory,
                onSelect: (cat) => setState(() => _selectedCategory = cat),
              ),
              const SizedBox(height: 24),

              // Popular professionals
              const SectionHeader(title: 'Popular Professionals'),
              const SizedBox(height: 14),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _professionals.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final prof = _professionals[index];
                  return ProfessionalListTile(
                    name: prof.name,
                    role: prof.role,
                    rating: prof.rating,
                    reviewCount: prof.reviewCount,
                  );
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Data models (local, mock-only)
// ---------------------------------------------------------------------------

class _CallData {
  const _CallData({
    required this.name,
    required this.role,
    required this.rating,
    required this.reviewCount,
  });

  final String name;
  final String role;
  final double rating;
  final int reviewCount;
}

class _ProfData {
  const _ProfData({
    required this.name,
    required this.role,
    required this.rating,
    required this.reviewCount,
  });

  final String name;
  final String role;
  final double rating;
  final int reviewCount;
}
