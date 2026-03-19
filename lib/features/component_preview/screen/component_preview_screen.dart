import 'package:flutter/material.dart';

import 'package:ohlify/features/component_preview/screen/parts/buttons_preview.dart';
import 'package:ohlify/features/component_preview/screen/parts/icon_buttons_preview.dart';
import 'package:ohlify/features/component_preview/screen/parts/inputs_preview.dart';
import 'package:ohlify/features/component_preview/screen/parts/tags_preview.dart';
import 'package:ohlify/features/component_preview/screen/parts/typography_preview.dart';
import 'package:ohlify/features/component_preview/screen/parts/typography_variants_preview.dart';
import 'package:ohlify/ui/theme/app_colors.dart';

class ComponentPreviewScreen extends StatelessWidget {
  const ComponentPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Component Preview'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
        children: const [
          _PreviewSection(title: 'Typography', child: TypographyPreview()),
          SizedBox(height: 16),
          _PreviewSection(title: 'Typography Variants', child: TypographyVariantsPreview()),
          SizedBox(height: 16),
          _PreviewSection(title: 'Buttons', child: ButtonsPreview()),
          SizedBox(height: 16),
          _PreviewSection(title: 'Icon Buttons', child: IconButtonsPreview()),
          SizedBox(height: 16),
          _PreviewSection(title: 'Inputs', child: InputsPreview()),
          SizedBox(height: 16),
          _PreviewSection(title: 'Tags', child: TagsPreview()),
        ],
      ),
    );
  }
}

class _PreviewSection extends StatefulWidget {
  const _PreviewSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  State<_PreviewSection> createState() => _PreviewSectionState();
}

class _PreviewSectionState extends State<_PreviewSection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.title.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.tertiary,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              AnimatedRotation(
                turns: _expanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 18,
                  color: AppColors.tertiary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        const Divider(color: AppColors.border, height: 1),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: widget.child,
          ),
          crossFadeState:
              _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 220),
          sizeCurve: Curves.easeInOut,
        ),
      ],
    );
  }
}
