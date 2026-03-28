import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

class AppTabItem {
  const AppTabItem({required this.label, required this.child});

  final String label;
  final Widget child;
}

/// A segmented tab switcher that preserves each tab's state via [IndexedStack].
///
/// Usage:
/// ```dart
/// AppTabView(
///   tabs: [
///     AppTabItem(label: 'Scheduled calls', child: ScheduledCallsList()),
///     AppTabItem(label: 'Completed calls', child: CompletedCallsList()),
///   ],
/// )
/// ```
class AppTabView extends StatefulWidget {
  const AppTabView({super.key, required this.tabs});

  final List<AppTabItem> tabs;

  @override
  State<AppTabView> createState() => _AppTabViewState();
}

class _AppTabViewState extends State<AppTabView> {
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TabBar(
          tabs: widget.tabs.map((t) => t.label).toList(),
          activeIndex: _activeIndex,
          onTap: (i) => setState(() => _activeIndex = i),
        ),
        const SizedBox(height: 16),
        IndexedStack(
          index: _activeIndex,
          children: widget.tabs.map((t) => t.child).toList(),
        ),
      ],
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({
    required this.tabs,
    required this.activeIndex,
    required this.onTap,
  });

  final List<String> tabs;
  final int activeIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          for (int i = 0; i < tabs.length; i++)
            Expanded(
              child: GestureDetector(
                onTap: () => onTap(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOutCubic,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: i == activeIndex
                        ? AppColors.background
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: i == activeIndex
                        ? [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: AppText(
                    tabs[i],
                    variant: AppTextVariant.body,
                    color: i == activeIndex
                        ? AppColors.textJet
                        : AppColors.textMuted,
                    weight: i == activeIndex
                        ? FontWeight.w700
                        : FontWeight.w400,
                    align: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
