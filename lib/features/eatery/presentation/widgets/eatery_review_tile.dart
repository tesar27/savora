import 'package:flutter/material.dart';

import '../../domain/models/eatery_review.dart';

/// A single review row inside the eatery detail reviews section.
class EateryReviewTile extends StatelessWidget {
  const EateryReviewTile({required this.review, super.key});

  final EateryReview review;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String initial = review.reviewerName.isNotEmpty
        ? review.reviewerName[0].toUpperCase()
        : '?';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFF42D88A),
                child: Text(
                  initial,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      review.reviewerName,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1C1F2D),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: <Widget>[
                        ...List<Widget>.generate(5, (int i) {
                          final bool filled = i < review.rating.floor();
                          final bool half =
                              i == review.rating.floor() &&
                              review.rating % 1 >= 0.5;
                          return Icon(
                            half
                                ? Icons.star_half_rounded
                                : filled
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            color: const Color(0xFF42D88A),
                            size: 16,
                          );
                        }),
                        const SizedBox(width: 6),
                        Text(
                          '| ${review.timeAgo}',
                          style: textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF9A9AAA),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (review.comment != null && review.comment!.isNotEmpty) ...<Widget>[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 52),
              child: Text(
                review.comment!,
                style: textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF4A4A5A),
                  height: 1.4,
                ),
              ),
            ),
          ],
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
        ],
      ),
    );
  }
}
