class UpcomingCall {
  const UpcomingCall({
    required this.id,
    required this.name,
    required this.role,
    required this.rating,
    required this.reviewCount,
    this.avatarUrl,
  });

  final String id;
  final String name;
  final String role;
  final double rating;
  final int reviewCount;
  final String? avatarUrl;
}
