import 'package:ohlify/shared/types/scheduled_call_item.dart';

class CallRate {
  const CallRate({
    required this.id,
    required this.callType,
    required this.durationMinutes,
    required this.price,
  });

  final String id;
  final CallType callType;
  final int durationMinutes;

  /// Display-formatted price, e.g. '₦ 10,800'.
  final String price;
}
