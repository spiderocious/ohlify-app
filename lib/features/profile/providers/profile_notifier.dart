import 'package:flutter/foundation.dart';

import 'package:ohlify/shared/services/services.dart';
import 'package:ohlify/shared/types/bank_details.dart';
import 'package:ohlify/shared/types/call_rate.dart';
import 'package:ohlify/shared/types/rates_controller.dart';

class ProfileNotifier extends ChangeNotifier implements RatesController {
  ProfileNotifier() {
    final seed = MockService.getProfileSeed();
    _fullName = seed['fullName'] as String;
    _email = seed['email'] as String;
    _phone = seed['phone'] as String;
    _description = seed['description'] as String;
    _occupation = seed['occupation'] as String;
    _interests = List<String>.from(seed['interests'] as List);
    final bank = seed['bankAccount'] as Map<String, dynamic>?;
    _bankAccount = bank == null
        ? null
        : BankDetails(
            accountNumber: bank['accountNumber'] as String,
            bankName: bank['bankName'] as String,
            accountName: bank['accountName'] as String?,
          );
    _smsNotifications = seed['smsNotifications'] as bool;
    _emailNotifications = seed['emailNotifications'] as bool;
  }

  late String _fullName;
  late String _email;
  late String _phone;
  late String _description;
  late String _occupation;
  late List<String> _interests;
  BankDetails? _bankAccount;
  late bool _smsNotifications;
  late bool _emailNotifications;
  final List<CallRate> _rates = [];
  int _nextRateId = 1;

  String get fullName => _fullName;
  String get email => _email;
  String get phone => _phone;
  String get description => _description;
  String get occupation => _occupation;
  List<String> get interests => List.unmodifiable(_interests);
  BankDetails? get bankAccount => _bankAccount;
  bool get smsNotifications => _smsNotifications;
  bool get emailNotifications => _emailNotifications;

  @override
  List<CallRate> get rates => List.unmodifiable(_rates);

  void setFullName(String value) {
    _fullName = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPhone(String value) {
    _phone = value;
    notifyListeners();
  }

  void setDescription(String value) {
    _description = value;
    notifyListeners();
  }

  void setOccupation(String value) {
    _occupation = value;
    notifyListeners();
  }

  void setInterests(List<String> values) {
    _interests = [...values];
    notifyListeners();
  }

  void setBankAccount(BankDetails value) {
    _bankAccount = value;
    notifyListeners();
  }

  void setSmsNotifications(bool value) {
    _smsNotifications = value;
    notifyListeners();
  }

  void setEmailNotifications(bool value) {
    _emailNotifications = value;
    notifyListeners();
  }

  // ── Rates ─────────────────────────────────────────────────────────────────

  @override
  void addRate(CallRate rate) {
    _rates.add(CallRate(
      id: rate.id.isEmpty ? _generateRateId() : rate.id,
      callType: rate.callType,
      durationMinutes: rate.durationMinutes,
      price: rate.price,
    ));
    notifyListeners();
  }

  @override
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
