class BankDetails {
  const BankDetails({
    required this.accountNumber,
    required this.bankName,
    this.accountName,
  });

  final String accountNumber;
  final String bankName;

  /// Name on the account, returned by the bank verification lookup.
  /// Null until verified.
  final String? accountName;
}
