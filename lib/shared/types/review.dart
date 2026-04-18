class Review {
  const Review({
    required this.id,
    required this.authorName,
    required this.rating,
    required this.comment,
    required this.timeAgo,
    this.authorAvatarUrl,
  });

  final String id;
  final String authorName;
  final double rating;
  final String comment;
  final String timeAgo;
  final String? authorAvatarUrl;
}
