enum KycItem {
  fullName,
  occupation,
  description,
  interests,
  bankAccount,
  identity,
  rates,
}

extension KycItemDisplay on KycItem {
  String get title => switch (this) {
        KycItem.fullName => 'Full name',
        KycItem.occupation => 'Occupation',
        KycItem.description => 'Description',
        KycItem.interests => 'Interests',
        KycItem.bankAccount => 'Bank account',
        KycItem.identity => 'Identity verification',
        KycItem.rates => 'Rates',
      };

  String get subtitle => switch (this) {
        KycItem.fullName => 'Enter your full legal name as it appears on ID.',
        KycItem.occupation =>
          'Let clients know what you do so you are easy to find.',
        KycItem.description => 'A short intro about who you are and how you help.',
        KycItem.interests => 'Pick topics so we can recommend you to the right people.',
        KycItem.bankAccount => 'We send your payouts here.',
        KycItem.identity => 'Verify your identity to keep the community safe.',
        KycItem.rates => 'Set what you charge per call type and duration.',
      };
}
