import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';

/// Drop this into any screen to visually confirm MonaSans is loading.
///
/// Compare the "MonaSans (forced)" row vs the "Arial (forced)" row —
/// they should look clearly different if the font is active. Pay attention
/// to the double-story 'a', the 'g', and the 't' crossbar.
class TypographyPreview extends StatelessWidget {
  const TypographyPreview({super.key});

  // Sentence chosen to expose Mona Sans's most distinctive glyphs.
  static const _probe = 'Ag Rt Gg — 0123 the quick fox';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Font-identity check ──────────────────────────────────────
        _label('Font identity check'),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _fontRow('MonaSans (forced)', 'MonaSans', FontWeight.w400),
              const SizedBox(height: 6),
              _fontRow('Arial (reference)', 'Arial', FontWeight.w400),
              const SizedBox(height: 6),
              _fontRow('Theme default', null, FontWeight.w400),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // ── Weight scale ─────────────────────────────────────────────
        _label('Weight scale (200 → 900)'),
        const SizedBox(height: 8),
        ..._weights.map(
          (w) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                SizedBox(
                  width: 44,
                  child: Text(
                    '${w.index}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textMuted,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    _probe,
                    style: TextStyle(
                      fontFamily: 'MonaSans',
                      fontWeight: w.weight,
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // ── Size scale ───────────────────────────────────────────────
        _label('Size scale'),
        const SizedBox(height: 8),
        ..._sizes.map(
          (s) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                SizedBox(
                  width: 30,
                  child: Text(
                    '${s.toInt()}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Ohlify — the quick brown fox',
                    style: TextStyle(
                      fontFamily: 'MonaSans',
                      fontWeight: FontWeight.w500,
                      fontSize: s,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static const _weights = [
    (index: 200, weight: FontWeight.w200),
    (index: 300, weight: FontWeight.w300),
    (index: 400, weight: FontWeight.w400),
    (index: 500, weight: FontWeight.w500),
    (index: 600, weight: FontWeight.w600),
    (index: 700, weight: FontWeight.w700),
    (index: 800, weight: FontWeight.w800),
    (index: 900, weight: FontWeight.w900),
  ];

  static const _sizes = [12.0, 14.0, 16.0, 20.0, 24.0, 32.0];

  Widget _fontRow(String label, String? family, FontWeight weight) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        SizedBox(
          width: 148,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textMuted,
            ),
          ),
        ),
        Expanded(
          child: Text(
            _probe,
            style: TextStyle(
              fontFamily: family,
              fontWeight: weight,
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textMuted,
        letterSpacing: 0.6,
      ),
    );
  }
}
