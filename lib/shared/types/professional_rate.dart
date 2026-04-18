import 'package:ohlify/shared/types/scheduled_call_item.dart';

class ProfessionalRate {
  const ProfessionalRate({
    required this.callType,
    required this.durationMinutes,
    required this.price,
  });

  final CallType callType;
  final int durationMinutes;

  /// Formatted price string e.g. "₦ 10,800"
  final String price;
}
