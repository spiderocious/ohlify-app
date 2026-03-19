import 'package:flutter/material.dart';

abstract final class AppColors {
  // Primary brand
  static const primary = Color(0xFF4A3FE5);        // #4A3FE5
  static const primaryHover = Color(0xFF3B31D4);   // #3B31D4

  // Semantic variants
  static const secondary = Color(0xFFE0DEFB);      // #E0DEFB — plain button bg
  static const tertiary = Color(0xFF68707E);        // #68707E — ghost / muted actions
  static const post = Color(0xFF0D6F82);            // #0D6F82 — post-related accent
  static const callico = Color(0x2E5E5E5E);         // #5E5E5E 18% — semi-transparent overlay
  static const danger = Color(0xFFFF1E21);          // #FF1E21
  static const accent = Color(0xFFFBBF24);          // #FBBF24

  // Neutrals
  static const background = Color(0xFFFFFFFF);      // #FFFFFF
  static const surface = Color(0xFFF9FAFB);         // #F9FAFB
  static const textPrimary = Color(0xFF111827);     // #111827
  static const textMuted = Color(0xFF6B7280);       // #6B7280
  static const border = Color(0xFFE5E7EB);          // #E5E7EB

  // Status
  static const error = Color(0xFFDC2626);           // #DC2626
  static const success = Color(0xFF16A34A);         // #16A34A
  static const warning = Color(0xFFD97706);         // #D97706

  // Toast backgrounds
  static const toastSuccessBg = Color(0xFF3FB12C);  // #3FB12C
  static const toastErrorBg = Color(0xFFD80027);    // #D80027
  static const toastWarningBg = Color(0xFF92400E);  // #92400E
  static const toastInfoBg = Color(0xFF1E3A5F);     // #1E3A5F

  // Toast icon tints
  static const toastSuccessIcon = Color(0xFF4ADE80); // #4ADE80
  static const toastErrorIcon = Color(0xFFFCA5A5);   // #FCA5A5
  static const toastWarningIcon = Color(0xFFFCD34D); // #FCD34D
  static const toastInfoIcon = Color(0xFF93C5FD);    // #93C5FD

  // Shell / nav
  static const navBackground = Color(0xFFF0EFF8);     // #F0EFF8 — bottom nav bg (lavender tint)
  static const navIconInactive = Color(0xFF5C5A8A);   // #5C5A8A — inactive nav icon

  // Text semantic colors
  static const textDeepBlue = Color(0xFF0F0872);    // #0F0872
  static const textSilver = Color(0xFF807E7E);      // #807E7E
  static const textJet = Color(0xFF08080C);         // #08080C
  static const textSlate = Color(0xFF868C98);       // #868C98
  static const textCharcoal = Color(0xFF4F555F);    // #4F555F
  static const textForest = Color(0xFF1F6F15);      // #1F6F15
  static const textBlack = Color(0xFF000000);       // #000000
  static const textWhite = Color(0xFFFFFFFF);       // #FFFFFF
  static const textNavy = Color(0xFF181176);        // #181176
  static const textAmber = Color(0xFFDC6803);       // #DC6803
  static const textDisabled = Color(0xFF999D9C);       // #999D9C
}
