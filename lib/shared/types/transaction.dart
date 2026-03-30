enum TransactionType { withdrawalToBank, paymentAudioCall, paymentVideoCall, scheduledAudioCall }

enum TransactionStatus { completed, pending, failed }

class Transaction {
  const Transaction({
    required this.id,
    required this.type,
    required this.datetime,
    required this.amount,
    required this.status,
  });

  final String id;
  final TransactionType type;
  final String datetime;

  /// Raw signed amount string e.g. "₦20,000.00", "-₦20,000.00", "+₦20,000.00"
  final String amount;
  final TransactionStatus status;

  String get title => switch (type) {
    TransactionType.withdrawalToBank   => 'Withdrawal to bank',
    TransactionType.paymentAudioCall   => 'Payment for audio call',
    TransactionType.paymentVideoCall   => 'Payment for video call',
    TransactionType.scheduledAudioCall => 'Scheduled audio call',
  };

  bool get isCredit => amount.startsWith('+');
  bool get isDebit  => amount.startsWith('-');
}
