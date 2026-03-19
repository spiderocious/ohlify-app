import 'package:flutter/material.dart';

import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/professional_rating/professional_rating.dart';

class UpcomingCallCard extends StatelessWidget {
  const UpcomingCallCard({
    super.key,
    required this.name,
    required this.role,
    required this.rating,
    required this.reviewCount,
    this.imageUrl,
    this.onTap,
  });

  final String name;
  final String role;
  final double rating;
  final int reviewCount;
  final String? imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Avatar
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, _) => _placeholder(),
                    )
                  : _placeholder(),
            ),
            const SizedBox(height: 12),

            // Name
            Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'MonaSans',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textNavy,
              ),
            ),
            const SizedBox(height: 4),

            // Role
            Text(
              role,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'MonaSans',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 10),

            // Rating
            ProfessionalRating(rating: rating, reviewCount: reviewCount),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(Icons.person, size: 40, color: AppColors.textMuted),
    );
  }
}
