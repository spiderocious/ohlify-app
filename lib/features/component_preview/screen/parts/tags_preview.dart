import 'package:flutter/material.dart';
import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_tag.dart';

class TagsPreview extends StatelessWidget {
  const TagsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Outline (default)'),
        const SizedBox(height: 12),
        const Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            AppTag(label: 'RELATIONSHIP'),
            AppTag(label: 'TECHNOLOGY'),
            AppTag(label: 'ENTERTAINMENT'),
            AppTag(label: 'HEALTH & WELLNESS'),
          ],
        ),
        const SizedBox(height: 24),
        _sectionLabel('Solid'),
        const SizedBox(height: 12),
        const Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            AppTag(
              label: 'AUDIO',
              variant: AppTagVariant.solid,
              color: Color(0xFF8F089B),
              startIcon: Icon(AppIcons.video, color: Colors.white),
            ),
            AppTag(
              label: 'VIDEO',
              variant: AppTagVariant.solid,
              color: Color(0xFF489B08),
              startIcon: Icon(AppIcons.video, color: Colors.white),
            ),
            AppTag(
              label: 'PRIMARY',
              variant: AppTagVariant.solid,
            ),
            AppTag(
              label: 'DANGER',
              variant: AppTagVariant.solid,
              color: AppColors.danger,
            ),
          ],
        ),
        const SizedBox(height: 24),
        _sectionLabel('Subtle'),
        const SizedBox(height: 12),
        const Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            AppTag(label: 'Design', variant: AppTagVariant.subtle),
            AppTag(label: 'Finance', variant: AppTagVariant.subtle),
            AppTag(
              label: 'With icon',
              variant: AppTagVariant.subtle,
              startIcon: Icon(AppIcons.star, color: Color(0xFF344272)),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _sectionLabel('Surface (greenish)'),
        const SizedBox(height: 12),
        const Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            AppTag(label: 'Active', variant: AppTagVariant.surface),
            AppTag(label: 'Verified', variant: AppTagVariant.surface),
            AppTag(
              label: 'Checked',
              variant: AppTagVariant.surface,
              endIcon: Icon(AppIcons.check, color: Color(0xFF1F6F15)),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _sectionLabel('Sizes'),
        const SizedBox(height: 12),
        const Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            AppTag(label: 'Small', size: AppTagSize.small),
            AppTag(label: 'Medium', size: AppTagSize.medium),
            AppTag(label: 'Large', size: AppTagSize.large),
          ],
        ),
        const SizedBox(height: 24),
        _sectionLabel('Radius'),
        const SizedBox(height: 12),
        const Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            AppTag(label: 'Full (pill)', radius: AppTagRadius.full),
            AppTag(label: 'Large (8px)', radius: AppTagRadius.large),
            AppTag(label: 'Small (4px)', radius: AppTagRadius.small),
            AppTag(label: 'None', radius: AppTagRadius.none),
          ],
        ),
        const SizedBox(height: 24),
        _sectionLabel('Disabled'),
        const SizedBox(height: 12),
        const Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            AppTag(label: 'Outline disabled', disabled: true),
            AppTag(
              label: 'Solid disabled',
              variant: AppTagVariant.solid,
              disabled: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _sectionLabel(String text) {
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
