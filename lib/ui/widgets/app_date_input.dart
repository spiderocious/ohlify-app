import 'package:flutter/material.dart';
import 'package:ohlify/ui/theme/app_colors.dart';

class AppDateInput extends StatefulWidget {
  const AppDateInput({
    super.key,
    this.value,
    this.onChanged,
    this.placeholder,
    this.disabled = false,
    this.bordered = true,
    this.borderColor = AppColors.border,
    this.errorMessage,
    this.minDate,
    this.maxDate,
    this.defaultDate,
    this.disabledDates,
    this.weekendDisabled = false,
    this.weekDaysDisabled,
    this.label,
  });

  final DateTime? value;
  final ValueChanged<DateTime>? onChanged;
  final String? placeholder;
  final bool disabled;
  final bool bordered;
  final Color borderColor;
  final String? errorMessage;
  final DateTime? minDate;
  final DateTime? maxDate;
  final DateTime? defaultDate;
  final List<DateTime>? disabledDates;
  final bool weekendDisabled;
  final List<String>? weekDaysDisabled; // e.g. ['Monday', 'Tuesday']
  final String? label;

  @override
  State<AppDateInput> createState() => _AppDateInputState();
}

class _AppDateInputState extends State<AppDateInput> {
  DateTime? _selected;
  late DateTime _viewMonth; // which month we're showing
  late final ScrollController _scroll;

  static const _weekDayNames = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  static const _monthNames = ['January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'];

  @override
  void initState() {
    super.initState();
    _selected = widget.value ?? widget.defaultDate;
    _viewMonth = DateTime(
      (_selected ?? DateTime.now()).year,
      (_selected ?? DateTime.now()).month,
    );
    _scroll = ScrollController();
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  List<DateTime> get _daysInView {
    final days = <DateTime>[];
    final daysInMonth = DateUtils.getDaysInMonth(_viewMonth.year, _viewMonth.month);
    for (var i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(_viewMonth.year, _viewMonth.month, i));
    }
    return days;
  }

  bool _isDisabled(DateTime date) {
    if (widget.disabled) return true;
    if (widget.minDate != null && date.isBefore(widget.minDate!)) return true;
    if (widget.maxDate != null && date.isAfter(widget.maxDate!)) return true;
    if (widget.weekendDisabled && (date.weekday == 6 || date.weekday == 7)) return true;
    if (widget.weekDaysDisabled != null) {
      final dayName = _weekDayNames[date.weekday - 1];
      if (widget.weekDaysDisabled!.contains(dayName)) return true;
    }
    if (widget.disabledDates != null) {
      return widget.disabledDates!.any((d) => DateUtils.isSameDay(d, date));
    }
    return false;
  }

  void _prevMonth() {
    setState(() {
      _viewMonth = DateTime(_viewMonth.year, _viewMonth.month - 1);
      _scroll.jumpTo(0);
    });
  }

  void _nextMonth() {
    setState(() {
      _viewMonth = DateTime(_viewMonth.year, _viewMonth.month + 1);
      _scroll.jumpTo(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final days = _daysInView;

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
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
          decoration: BoxDecoration(
            color: widget.disabled ? AppColors.surface : AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: widget.bordered || widget.errorMessage != null
                ? Border.all(
                    color: widget.errorMessage != null ? AppColors.error : widget.borderColor,
                    width: 1,
                  )
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  Text(
                    widget.placeholder ?? 'Select date',
                    style: const TextStyle(
                      fontFamily: 'MonaSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSlate,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: widget.disabled ? null : _prevMonth,
                    child: const Icon(Icons.chevron_left, size: 22, color: AppColors.textBlack),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _monthNames[_viewMonth.month - 1],
                    style: const TextStyle(
                      fontFamily: 'MonaSans',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textBlack,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.disabled ? null : _nextMonth,
                    child: const Icon(Icons.chevron_right, size: 22, color: AppColors.textBlack,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Horizontal date strip
              SizedBox(
                height: 88,
                child: ListView.separated(
                  controller: _scroll,
                  scrollDirection: Axis.horizontal,
                  itemCount: days.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (_, i) {
                    final day = days[i];
                    final isSelected = _selected != null && DateUtils.isSameDay(day, _selected!);
                    final isDisabled = _isDisabled(day);
                    final weekday = _weekDayNames[day.weekday - 1].substring(0, 3); // Mon, Tue…

                    return GestureDetector(
                      onTap: isDisabled ? null : () {
                        setState(() => _selected = day);
                        widget.onChanged?.call(day);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: 80,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.surface,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Opacity(
                          opacity: isDisabled && !isSelected ? 0.2 : 1.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${day.day}',
                                style: TextStyle(
                                  fontFamily: 'MonaSans',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? Colors.white : AppColors.textDisabled,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                weekday,
                                style: TextStyle(
                                  fontFamily: 'MonaSans',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: isSelected ? Colors.white.withValues(alpha: 0.85) : AppColors.textDisabled,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
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
