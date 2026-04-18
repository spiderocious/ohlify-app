import 'package:flutter/foundation.dart';

import 'package:ohlify/features/professional_kyc/types/bank_details.dart';
import 'package:ohlify/features/professional_kyc/types/identity_details.dart';
import 'package:ohlify/features/professional_kyc/types/kyc_item.dart';
import 'package:ohlify/features/professional_kyc/types/kyc_rate.dart';

class ProfessionalKycNotifier extends ChangeNotifier {
  String? _occupation;
  String? _description;
  final List<String> _interests = [];
  BankDetails? _bankAccount;
  IdentityDetails? _identity;
  final List<KycRate> _rates = [];
  int _nextRateId = 1;

  String? get occupation => _occupation;
  String? get description => _description;
  List<String> get interests => List.unmodifiable(_interests);
  BankDetails? get bankAccount => _bankAccount;
  IdentityDetails? get identity => _identity;
  List<KycRate> get rates => List.unmodifiable(_rates);

  bool isComplete(KycItem item) => switch (item) {
        KycItem.occupation => _occupation != null && _occupation!.isNotEmpty,
        KycItem.description => _description != null && _description!.isNotEmpty,
        KycItem.interests => _interests.isNotEmpty,
        KycItem.bankAccount => _bankAccount != null,
        KycItem.identity => _identity != null,
        KycItem.rates => _rates.isNotEmpty,
      };

  int get completedCount =>
      KycItem.values.where(isComplete).length;

  double get completionRatio => completedCount / KycItem.values.length;

  int get completionPercent => (completionRatio * 100).round();

  // ── Setters ───────────────────────────────────────────────────────────────

  void setOccupation(String value) {
    _occupation = value;
    notifyListeners();
  }

  void setDescription(String value) {
    _description = value;
    notifyListeners();
  }

  void addInterest(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return;
    if (_interests.any((i) => i.toLowerCase() == trimmed.toLowerCase())) return;
    _interests.add(trimmed);
    notifyListeners();
  }

  void removeInterest(String value) {
    _interests.remove(value);
    notifyListeners();
  }

  void setBankAccount(BankDetails value) {
    _bankAccount = value;
    notifyListeners();
  }

  void setIdentity(IdentityDetails value) {
    _identity = value;
    notifyListeners();
  }

  // ── Rates ─────────────────────────────────────────────────────────────────

  void addRate({
    required KycRate rate,
  }) {
    _rates.add(KycRate(
      id: rate.id.isEmpty ? _generateRateId() : rate.id,
      callType: rate.callType,
      durationMinutes: rate.durationMinutes,
      price: rate.price,
    ));
    notifyListeners();
  }

  void removeRate(String id) {
    _rates.removeWhere((r) => r.id == id);
    notifyListeners();
  }

  String _generateRateId() {
    final id = 'rate-${_nextRateId.toString().padLeft(3, '0')}';
    _nextRateId++;
    return id;
  }
}
