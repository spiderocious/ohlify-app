class Professional {
  const Professional({
    required this.id,
    required this.name,
    required this.role,
    required this.rating,
    required this.reviewCount,
    this.avatarUrl,
    this.basePrice,
  });

  final String id;
  final String name;
  final String role;
  final double rating;
  final int reviewCount;
  final String? avatarUrl;

  /// Starting price in NGN (whole naira). Used for sorting in search.
  final num? basePrice;
}
