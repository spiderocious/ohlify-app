import 'package:ohlify/shared/types/bank_details.dart';

class ProfileData {
  const ProfileData({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.description,
    required this.occupation,
    required this.interests,
    required this.bankAccount,
    required this.smsNotifications,
    required this.emailNotifications,
  });

  final String fullName;
  final String email;
  final String phone;
  final String description;
  final String occupation;
  final List<String> interests;
  final BankDetails? bankAccount;
  final bool smsNotifications;
  final bool emailNotifications;
}
