import 'package:flutter/foundation.dart';

import 'package:ohlify/shared/types/call_rate.dart';

/// Minimum surface a rates-list screen needs. Concrete notifiers (profile,
/// professional kyc, etc.) implement this so the rates screen stays
/// feature-agnostic.
abstract class RatesController implements Listenable {
  List<CallRate> get rates;

  void addRate(CallRate rate);

  void removeRate(String id);
}
