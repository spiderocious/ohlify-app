enum ClientKycItem { fullName, interests, description }

extension ClientKycItemDisplay on ClientKycItem {
  String get title => switch (this) {
        ClientKycItem.fullName => 'Full name',
        ClientKycItem.interests => 'Interests',
        ClientKycItem.description => 'Description',
      };

  String get subtitle => switch (this) {
        ClientKycItem.fullName =>
          'Enter your full legal name as it appears on ID.',
        ClientKycItem.interests =>
          'Pick topics so we can recommend the right people for you.',
        ClientKycItem.description =>
          'A short intro about who you are so professionals know who they are speaking with.',
      };
}
