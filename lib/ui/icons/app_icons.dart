import 'package:flutter/material.dart';

// All icons used in the app must go through AppIcons.
// Never reference Icons.* directly in widgets.
abstract final class AppIcons {
  // Navigation
  static const chevronRight = Icons.chevron_right;
  static const chevronLeft = Icons.chevron_left;
  static const chevronDown = Icons.keyboard_arrow_down;
  static const back = Icons.arrow_back;

  // Bottom nav
  static const navHome = Icons.home_rounded;
  static const navCalls = Icons.calendar_today_rounded;
  static const navWallet = Icons.account_balance_wallet_rounded;
  static const navProfile = Icons.account_circle_rounded;

  // Header actions
  static const copyLink = Icons.copy_rounded;
  static const notification = Icons.notifications_rounded;

  // Actions
  static const close = Icons.close;
  static const add = Icons.add;
  static const edit = Icons.edit_outlined;
  static const delete = Icons.delete_outline;
  static const search = Icons.search;
  static const logout = Icons.logout;

  // Status / feedback
  static const check = Icons.check;
  static const info = Icons.info_outline;
  static const warning = Icons.warning_amber_outlined;
  static const error = Icons.error_outline;

  // Visibility
  static const eye = Icons.visibility_outlined;
  static const eyeOff = Icons.visibility_off_outlined;

  // Communication
  static const phone = Icons.phone;
  static const video = Icons.videocam;
  static const chat = Icons.chat_bubble_outline;

  // Social / ratings
  static const star = Icons.star;
  static const medal = Icons.military_tech;

  // Profile / settings
  static const person = Icons.person_outline;
  static const settings = Icons.settings_outlined;

  // Finance
  static const building = Icons.account_balance_outlined;

  // Dev tools
  static const components = Icons.widgets_outlined;
}
