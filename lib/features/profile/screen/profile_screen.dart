import 'package:flutter/material.dart';

import 'package:ohlify/features/profile/screen/parts/profile_link_card.dart';
import 'package:ohlify/features/profile/screen/parts/profile_menu.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Mock — replace with provider data when auth is wired
  static const _name = 'Adedeji Benson Bamidele';
  static const _profileUrl = 'www.ohlify.com/profile/seidu23';

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
              const SizedBox(height: 12),
              const _ProfileHeader(name: _name),
              const SizedBox(height: 20),
              ProfileLinkCard(
                profileUrl: _profileUrl,
                onCopy: () {},
              ),
              const SizedBox(height: 28),
              ProfileMenu(
                onPersonalInfo: () {},
                onRates: () {},
                onBankAccount: () {},
                onChangePassword: () {},
                onNotifications: () {},
                onHelpDesk: () {},
                onPrivacyPolicy: () {},
                onEula: () {},
                onLogout: () {},
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText(
                'Your Profile',
                variant: AppTextVariant.title,
                color: AppColors.textJet,
                align: TextAlign.start,
                weight: FontWeight.w800,
              ),
              const SizedBox(height: 2),
              AppText(
                name,
                variant: AppTextVariant.body,
                color: AppColors.textMuted,
                align: TextAlign.start,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFF4ECDC4),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ],
    );
  }
}
