import 'package:go_router/go_router.dart';

import 'package:ohlify/features/profile/screen/bank_account_screen.dart';
import 'package:ohlify/features/profile/screen/change_password_screen.dart';
import 'package:ohlify/features/profile/screen/eula_screen.dart';
import 'package:ohlify/features/profile/screen/help_desk_screen.dart';
import 'package:ohlify/features/profile/screen/notification_preferences_screen.dart';
import 'package:ohlify/features/profile/screen/personal_info_screen.dart';
import 'package:ohlify/features/profile/screen/privacy_policy_screen.dart';
import 'package:ohlify/features/profile/screen/profile_rates_screen.dart';
import 'package:ohlify/features/profile/screen/terms_screen.dart';
import 'package:ohlify/shared/constants/app_routes.dart';

final profileSubscreenRoutes = [
  GoRoute(
    path: AppRoutes.profilePersonalInfo,
    builder: (context, state) => const PersonalInfoScreen(),
  ),
  GoRoute(
    path: AppRoutes.profileRates,
    builder: (context, state) => const ProfileRatesScreen(),
  ),
  GoRoute(
    path: AppRoutes.profileBankAccount,
    builder: (context, state) => const BankAccountScreen(),
  ),
  GoRoute(
    path: AppRoutes.profileChangePassword,
    builder: (context, state) => const ChangePasswordScreen(),
  ),
  GoRoute(
    path: AppRoutes.profileNotifications,
    builder: (context, state) => const NotificationPreferencesScreen(),
  ),
  GoRoute(
    path: AppRoutes.profileHelpDesk,
    builder: (context, state) => const HelpDeskScreen(),
  ),
  GoRoute(
    path: AppRoutes.profilePrivacyPolicy,
    builder: (context, state) => const PrivacyPolicyScreen(),
  ),
  GoRoute(
    path: AppRoutes.profileEula,
    builder: (context, state) => const EulaScreen(),
  ),
  GoRoute(
    path: AppRoutes.profileTerms,
    builder: (context, state) => const TermsScreen(),
  ),
];
