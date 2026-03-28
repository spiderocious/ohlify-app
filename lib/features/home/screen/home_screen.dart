import 'package:flutter/material.dart';

import 'package:ohlify/features/home/screen/parts/upcoming_call_banner.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_search_bar/app_search_bar.dart';

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
      backgroundColor: AppColors.surfaceLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Search bar
              AppSearchBar(readOnly: true, onTap: () {}),
              const SizedBox(height: 24),

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
