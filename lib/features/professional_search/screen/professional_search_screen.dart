import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ohlify/features/professional_search/screen/parts/search_results_list.dart';
import 'package:ohlify/features/professional_search/screen/parts/sort_filter.dart';
import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/shared/services/services.dart';
import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_icon_button/app_icon_button.dart';
import 'package:ohlify/ui/widgets/app_search_bar/app_search_bar.dart';

class ProfessionalSearchScreen extends StatefulWidget {
  const ProfessionalSearchScreen({super.key, this.autofocus = false});

  /// When true the search field takes focus on mount (opens the keyboard).
  /// Passed as query param `focus=1` when entering from the home search bar.
  final bool autofocus;

  @override
  State<ProfessionalSearchScreen> createState() =>
      _ProfessionalSearchScreenState();
}

class _ProfessionalSearchScreenState extends State<ProfessionalSearchScreen> {
  static const _debounceDuration = Duration(milliseconds: 300);

  final _searchFocus = FocusNode();
  final _searchController = TextEditingController();

  Timer? _debounce;
  String _query = '';
  SortOption _sort = const SortOption(
    key: SortKey.rating,
    direction: SortDirection.desc,
  );

  @override
  void dispose() {
    _debounce?.cancel();
    _searchFocus.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onQueryChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(_debounceDuration, () {
      if (!mounted) return;
      setState(() => _query = value.trim());
    });
  }

  List<Professional> _filtered() {
    final all = MockService.getProfessionals();
    final q = _query.toLowerCase();

    final matched = q.isEmpty
        ? [...all]
        : all.where((p) {
            return p.name.toLowerCase().contains(q) ||
                p.role.toLowerCase().contains(q);
          }).toList();

    matched.sort((a, b) {
      final cmp = switch (_sort.key) {
        SortKey.rating => a.rating.compareTo(b.rating),
        SortKey.price => (a.basePrice ?? 0).compareTo(b.basePrice ?? 0),
        SortKey.name => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      };
      return _sort.direction == SortDirection.asc ? cmp : -cmp;
    });

    return matched;
  }

  @override
  Widget build(BuildContext context) {
    final results = _filtered();

    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  AppIconButton(
                    icon: const Icon(AppIcons.back, color: AppColors.textJet),
                    variant: AppIconButtonVariant.ghost,
                    backgroundColor: AppColors.background,
                    size: 44,
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AppSearchBar(
                      placeholder: 'Search professional',
                      controller: _searchController,
                      focusNode: _searchFocus,
                      autofocus: widget.autofocus,
                      onChanged: _onQueryChanged,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SortFilter(
                value: _sort,
                onChanged: (opt) => setState(() => _sort = opt),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: SearchResultsList(
                  professionals: results,
                  onTap: (pro) =>
                      context.push('${AppRoutes.professional}/${pro.id}'),
                  onSchedule: (pro) =>
                      context.push('${AppRoutes.scheduleCall}/${pro.id}'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
