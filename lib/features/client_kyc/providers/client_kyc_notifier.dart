import 'package:flutter/foundation.dart';

import 'package:ohlify/features/client_kyc/types/client_kyc_item.dart';

class ClientKycNotifier extends ChangeNotifier {
  String? _fullName;
  String? _description;
  final List<String> _interests = [];

  String? get fullName => _fullName;
  String? get description => _description;
  List<String> get interests => List.unmodifiable(_interests);

  bool isComplete(ClientKycItem item) => switch (item) {
        ClientKycItem.fullName => _fullName != null && _fullName!.isNotEmpty,
        ClientKycItem.description =>
          _description != null && _description!.isNotEmpty,
        ClientKycItem.interests => _interests.isNotEmpty,
      };

  int get completedCount => ClientKycItem.values.where(isComplete).length;

  double get completionRatio => completedCount / ClientKycItem.values.length;

  int get completionPercent => (completionRatio * 100).round();

  void setFullName(String value) {
    _fullName = value;
    notifyListeners();
  }

  void setDescription(String value) {
    _description = value;
    notifyListeners();
  }

  void setInterests(List<String> values) {
    _interests
      ..clear()
      ..addAll(values);
    notifyListeners();
  }
}
