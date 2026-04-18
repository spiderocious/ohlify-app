import 'package:flutter/material.dart';
import 'package:ohlify/ui/theme/app_colors.dart';

class DropdownOption<T> {
  const DropdownOption({required this.label, required this.value, this.icon});
  final String label;
  final T value;
  final Widget? icon;
}

class AppDropdownInput<T> extends StatefulWidget {
  const AppDropdownInput({
    super.key,
    required this.options,
    this.value,
    this.onChanged,
    this.placeholder,
    this.disabled = false,
    this.bordered = false,
    this.borderColor = AppColors.border,
    this.errorMessage,
    this.searchable = false,
    this.label,
  });

  final List<DropdownOption<T>> options;
  final T? value;
  final ValueChanged<T>? onChanged;
  final String? placeholder;
  final bool disabled;
  final bool bordered;
  final Color borderColor;
  final String? errorMessage;
  final bool searchable;
  final String? label;

  @override
  State<AppDropdownInput<T>> createState() => _AppDropdownInputState<T>();
}

class _AppDropdownInputState<T> extends State<AppDropdownInput<T>> {
  DropdownOption<T>? _selected;
  bool _open = false;
  String _search = '';
  double _targetWidth = 0;
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _targetKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      _selected = widget.options.firstWhere(
        (o) => o.value == widget.value,
        orElse: () => widget.options.first,
      );
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    _searchController.dispose();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _toggleDropdown() {
    if (widget.disabled) return;
    if (_open) {
      setState(() => _open = false);
      _removeOverlay();
      return;
    }
    final box = _targetKey.currentContext?.findRenderObject() as RenderBox?;
    _targetWidth = box?.size.width ?? 0;
    setState(() => _open = true);
    _showOverlay();
  }

  void _closeDropdown() {
    setState(() {
      _open = false;
      _search = '';
      _searchController.clear();
    });
    _removeOverlay();
  }

  void _select(DropdownOption<T> option) {
    setState(() => _selected = option);
    widget.onChanged?.call(option.value);
    _closeDropdown();
  }

  void _showOverlay() {
    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (_) => _DropdownOverlay(
        layerLink: _layerLink,
        width: _targetWidth,
        options: widget.options,
        selected: _selected,
        searchable: widget.searchable,
        searchController: _searchController,
        onSelect: _select,
        onDismiss: _closeDropdown,
        search: _search,
        onSearchChanged: (v) {
          _search = v;
          _overlayEntry?.markNeedsBuild();
        },
      ),
    );
    overlay.insert(_overlayEntry!);
  }

  Color get _borderColor {
    if (widget.errorMessage != null) return AppColors.error;
    if (_open) return AppColors.primary;
    return widget.bordered ? widget.borderColor : Colors.transparent;
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
            onTap: _toggleDropdown,
            child: AnimatedContainer(
              key: _targetKey,
              duration: const Duration(milliseconds: 150),
              height: 52,
              decoration: BoxDecoration(
                color: widget.disabled ? AppColors.surface : AppColors.background,
                borderRadius: BorderRadius.circular(12),
                border: widget.bordered || widget.errorMessage != null || _open
                    ? Border.all(color: _borderColor, width: _open ? 1.5 : 1)
                    : null,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  if (_selected?.icon != null) ...[
                    _selected!.icon!,
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Text(
                      _selected?.label ?? widget.placeholder ?? 'Select...',
                      style: TextStyle(
                        fontFamily: _selected != null ? 'MonaSans' : 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: _selected != null ? AppColors.textPrimary : AppColors.textSlate,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  AnimatedRotation(
                    turns: _open ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.keyboard_arrow_down, size: 20, color: AppColors.textSlate),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (widget.errorMessage != null) ...[
          const SizedBox(height: 6),
          Text(
            widget.errorMessage!,
            style: const TextStyle(
              fontFamily: 'MonaSans',
              fontSize: 12,
              color: AppColors.error,
            ),
          ),
        ],
      ],
    );
  }
}

class _DropdownOverlay<T> extends StatefulWidget {
  const _DropdownOverlay({
    required this.layerLink,
    required this.width,
    required this.options,
    required this.selected,
    required this.searchable,
    required this.searchController,
    required this.onSelect,
    required this.onDismiss,
    required this.search,
    required this.onSearchChanged,
  });

  final LayerLink layerLink;
  final double width;
  final List<DropdownOption<T>> options;
  final DropdownOption<T>? selected;
  final bool searchable;
  final TextEditingController searchController;
  final ValueChanged<DropdownOption<T>> onSelect;
  final VoidCallback onDismiss;
  final String search;
  final ValueChanged<String> onSearchChanged;

  @override
  State<_DropdownOverlay<T>> createState() => _DropdownOverlayState<T>();
}

class _DropdownOverlayState<T> extends State<_DropdownOverlay<T>> {
  @override
  Widget build(BuildContext context) {
    final filtered = widget.search.isEmpty
        ? widget.options
        : widget.options
            .where((o) => o.label.toLowerCase().contains(widget.search.toLowerCase()))
            .toList();

    return Stack(
      children: [
        // Dismiss tap area
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
              constraints: const BoxConstraints(maxHeight: 240),
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
                  if (widget.searchable)
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        controller: widget.searchController,
                        style: const TextStyle(fontFamily: 'MonaSans', fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          hintStyle: const TextStyle(color: AppColors.textSlate, fontSize: 14),
                          prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.textSlate),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: AppColors.border),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: AppColors.border),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
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
                        final isSelected = opt.value == widget.selected?.value;
                        return InkWell(
                          onTap: () => widget.onSelect(opt),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            color: isSelected ? AppColors.secondary.withValues(alpha: 0.5) : null,
                            child: Row(
                              children: [
                                if (opt.icon != null) ...[
                                  opt.icon!,
                                  const SizedBox(width: 10),
                                ],
                                Expanded(
                                  child: Text(
                                    opt.label,
                                    style: TextStyle(
                                      fontFamily: 'MonaSans',
                                      fontSize: 15,
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  const Icon(Icons.check, size: 16, color: AppColors.primary),
                              ],
                            ),
                          ),
                        );
                      },
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
