import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_dropdown_input/app_dropdown_input.dart';
import 'package:ohlify/ui/widgets/app_tag/app_tag.dart';

/// Multi-select searchable dropdown with an optional "Other" free-text
/// fallback. Selected values render as removable chips above the field.
///
/// Usage:
/// ```dart
/// AppMultiSelectDropdown(
///   label: 'Interests',
///   options: const [
///     DropdownOption(label: 'Relationship', value: 'Relationship'),
///     DropdownOption(label: 'Technology', value: 'Technology'),
///   ],
///   selected: _interests,
///   allowOther: true,
///   onChanged: (values) => setState(() => _interests = values),
/// )
/// ```
class AppMultiSelectDropdown extends StatefulWidget {
  const AppMultiSelectDropdown({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
    this.placeholder = 'Search and select',
    this.label,
    this.allowOther = false,
    this.otherPlaceholder = 'Add a custom option',
  });

  final List<DropdownOption<String>> options;
  final List<String> selected;
  final ValueChanged<List<String>> onChanged;
  final String placeholder;
  final String? label;

  /// When true, the bottom of the popup includes a free-text field that lets
  /// the user add a value that isn't in [options].
  final bool allowOther;
  final String otherPlaceholder;

  @override
  State<AppMultiSelectDropdown> createState() =>
      _AppMultiSelectDropdownState();
}

class _AppMultiSelectDropdownState extends State<AppMultiSelectDropdown> {
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _targetKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool _open = false;
  String _search = '';
  double _targetWidth = 0;

  @override
  void didUpdateWidget(covariant AppMultiSelectDropdown old) {
    super.didUpdateWidget(old);
    // Selected list / options may have changed while the popup is open;
    // repaint it so the checkmarks reflect the latest state.
    // Deferred to the next frame — marking another element dirty while the
    // framework is still building (i.e. during this callback) throws.
    final entry = _overlayEntry;
    if (entry == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (_overlayEntry == entry) entry.markNeedsBuild();
    });
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _toggle() {
    if (_open) {
      _close();
    } else {
      _measureAndOpen();
    }
  }

  void _measureAndOpen() {
    final box = _targetKey.currentContext?.findRenderObject() as RenderBox?;
    _targetWidth = box?.size.width ?? 0;
    setState(() => _open = true);
    _showOverlay();
  }

  void _close() {
    if (!_open) return;
    setState(() {
      _open = false;
      _search = '';
    });
    _removeOverlay();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _toggleValue(String value) {
    final next = [...widget.selected];
    if (next.any((v) => v.toLowerCase() == value.toLowerCase())) {
      next.removeWhere((v) => v.toLowerCase() == value.toLowerCase());
    } else {
      next.add(value);
    }
    widget.onChanged(next);
  }

  void _addOther(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return;
    if (widget.selected.any((v) => v.toLowerCase() == trimmed.toLowerCase())) {
      return;
    }
    widget.onChanged([...widget.selected, trimmed]);
  }

  void _showOverlay() {
    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (_) => _Popup(
        layerLink: _layerLink,
        width: _targetWidth,
        options: widget.options,
        selected: widget.selected,
        search: _search,
        allowOther: widget.allowOther,
        otherPlaceholder: widget.otherPlaceholder,
        onSearchChanged: (v) {
          _search = v;
          _overlayEntry?.markNeedsBuild();
        },
        onToggle: _toggleValue,
        onAddOther: _addOther,
        onDismiss: _close,
      ),
    );
    overlay.insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: const TextStyle(
              fontFamily: 'MonaSans',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
        ],
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: _toggle,
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              key: _targetKey,
              duration: const Duration(milliseconds: 150),
              constraints: const BoxConstraints(minHeight: 52),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _open ? AppColors.primary : AppColors.border,
                  width: _open ? 1.5 : 1,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: widget.selected.isEmpty
                  ? Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.placeholder,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              color: AppColors.textSlate,
                            ),
                          ),
                        ),
                        AnimatedRotation(
                          turns: _open ? 0.5 : 0,
                          duration: const Duration(milliseconds: 180),
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            size: 20,
                            color: AppColors.textSlate,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              for (final value in widget.selected)
                                AppTag(
                                  label: value.toUpperCase(),
                                  variant: AppTagVariant.outline,
                                  size: AppTagSize.small,
                                  endIcon: const Icon(
                                    Icons.close_rounded,
                                    size: 12,
                                  ),
                                  onTap: () => _toggleValue(value),
                                ),
                            ],
                          ),
                        ),
                        AnimatedRotation(
                          turns: _open ? 0.5 : 0,
                          duration: const Duration(milliseconds: 180),
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            size: 20,
                            color: AppColors.textSlate,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Popup extends StatefulWidget {
  const _Popup({
    required this.layerLink,
    required this.width,
    required this.options,
    required this.selected,
    required this.search,
    required this.allowOther,
    required this.otherPlaceholder,
    required this.onSearchChanged,
    required this.onToggle,
    required this.onAddOther,
    required this.onDismiss,
  });

  final LayerLink layerLink;
  final double width;
  final List<DropdownOption<String>> options;
  final List<String> selected;
  final String search;
  final bool allowOther;
  final String otherPlaceholder;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onToggle;
  final ValueChanged<String> onAddOther;
  final VoidCallback onDismiss;

  @override
  State<_Popup> createState() => _PopupState();
}

class _PopupState extends State<_Popup> {
  late final TextEditingController _searchController;
  late final TextEditingController _otherController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.search);
    _otherController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _otherController.dispose();
    super.dispose();
  }

  bool _isSelected(String value) =>
      widget.selected.any((v) => v.toLowerCase() == value.toLowerCase());

  @override
  Widget build(BuildContext context) {
    final filtered = widget.search.isEmpty
        ? widget.options
        : widget.options
            .where((o) =>
                o.label.toLowerCase().contains(widget.search.toLowerCase()))
            .toList();

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: widget.onDismiss,
            behavior: HitTestBehavior.opaque,
            child: const SizedBox.expand(),
          ),
        ),
        CompositedTransformFollower(
          link: widget.layerLink,
          showWhenUnlinked: false,
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          offset: const Offset(0, 6),
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: widget.width > 0 ? widget.width : null,
              constraints: const BoxConstraints(maxHeight: 320),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(
                        fontFamily: 'MonaSans',
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: const TextStyle(
                          color: AppColors.textSlate,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 18,
                          color: AppColors.textSlate,
                        ),
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: AppColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: AppColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                            width: 1.5,
                          ),
                        ),
                      ),
                      onChanged: widget.onSearchChanged,
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      shrinkWrap: true,
                      itemCount: filtered.length,
                      itemBuilder: (_, i) {
                        final opt = filtered[i];
                        final isSelected = _isSelected(opt.value);
                        return InkWell(
                          onTap: () => widget.onToggle(opt.value),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            color: isSelected
                                ? AppColors.secondary.withValues(alpha: 0.4)
                                : null,
                            child: Row(
                              children: [
                                _Checkbox(checked: isSelected),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    opt.label,
                                    style: TextStyle(
                                      fontFamily: 'MonaSans',
                                      fontSize: 15,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (widget.allowOther) ...[
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.border,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        controller: _otherController,
                        style: const TextStyle(
                          fontFamily: 'MonaSans',
                          fontSize: 14,
                        ),
                        textInputAction: TextInputAction.done,
                        onSubmitted: (v) {
                          widget.onAddOther(v);
                          _otherController.clear();
                        },
                        decoration: InputDecoration(
                          hintText: widget.otherPlaceholder,
                          hintStyle: const TextStyle(
                            color: AppColors.textSlate,
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                            Icons.add_rounded,
                            size: 18,
                            color: AppColors.textSlate,
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.check_circle_rounded,
                              size: 20,
                              color: AppColors.primary,
                            ),
                            onPressed: () {
                              widget.onAddOther(_otherController.text);
                              _otherController.clear();
                            },
                          ),
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: AppColors.border),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: AppColors.border),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Checkbox extends StatelessWidget {
  const _Checkbox({required this.checked});

  final bool checked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: checked ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: checked ? AppColors.primary : AppColors.border,
          width: 1.5,
        ),
      ),
      child: checked
          ? const Icon(Icons.check_rounded, size: 14, color: Colors.white)
          : null,
    );
  }
}
