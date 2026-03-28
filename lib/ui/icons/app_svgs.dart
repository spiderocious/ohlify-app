/// Centralised registry for all SVG asset paths.
///
/// Flags live under `assets/svg/flags/{country-code}.svg`
/// Custom icons live under `assets/svg/icons/{name}.svg`
///
/// Usage:
/// ```dart
/// AppSvg(AppSvgs.flagNg)
/// AppSvg(AppSvgs.flagNg, size: 24)
/// AppSvg(AppSvgs.someIcon, color: AppColors.primary)
/// ```
abstract final class AppSvgs {
  // ── Flags ──────────────────────────────────────────────────────────
  static const flagNg = 'assets/svg/flags/ng.svg'; // 🇳🇬 Nigeria

  // ── Logo ───────────────────────────────────────────────────────────
  /// Full Ohlify wordmark (82×28). Pass [color] to tint, or leave null
  /// to preserve the original two-colour design.
  static const logo = 'assets/svg/icons/logo.svg';

  // ── Bottom nav icons ───────────────────────────────────────────────
  /// Inactive colour (#64619C) is baked into the SVG fill.
  /// Pass `color: AppColors.primary` (white works too inside the pill)
  /// via [AppSvg] to switch to the active state.
  static const navHome    = 'assets/svg/icons/nav_home.svg';
  static const navCalls   = 'assets/svg/icons/nav_calls.svg';
  static const navWallet  = 'assets/svg/icons/nav_wallet.svg';
  static const navProfile = 'assets/svg/icons/nav_profile.svg';

  // ── Action icons ───────────────────────────────────────────────────
  static const copy = 'assets/svg/icons/ic_copy.svg';

  // ── Rating ─────────────────────────────────────────────────────────
  static const ratingBadge = 'assets/svg/icons/ic_rating_badge.svg';

  // ── Calls stats ────────────────────────────────────────────────────────
  static const totalCallsIcon = 'assets/svg/icons/total-calls-icon.svg';
  static const monthIcon      = 'assets/svg/icons/month-icon.svg';
  static const weekIcon       = 'assets/svg/icons/week-icon.svg';

  // ── Call meta ──────────────────────────────────────────────────────────
  static const clock      = 'assets/svg/icons/clock.svg';
  static const calendar   = 'assets/svg/icons/calendar.svg';
  static const stopwatch  = 'assets/svg/icons/stopwatch.svg';
}
