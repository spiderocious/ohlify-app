enum IdentityType { nin, bvn, passport, driversLicense }

extension IdentityTypeDisplay on IdentityType {
  String get label => switch (this) {
        IdentityType.nin => 'NIN',
        IdentityType.bvn => 'BVN',
        IdentityType.passport => 'International Passport',
        IdentityType.driversLicense => 'Driver\'s License',
      };
}

class IdentityDetails {
  const IdentityDetails({
    required this.type,
    required this.number,
    required this.fileName,
  });

  final IdentityType type;
  final String number;

  /// Name of the uploaded document. We only store the name here; the actual
  /// upload happens at the API layer when real endpoints land.
  final String fileName;
}
