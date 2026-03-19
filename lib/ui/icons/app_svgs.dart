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

  // ── Custom icons ───────────────────────────────────────────────────
  // Add exported Figma SVG icons here as you go, e.g.:
  // static const arrowRight = 'assets/svg/icons/arrow-right.svg';
}
