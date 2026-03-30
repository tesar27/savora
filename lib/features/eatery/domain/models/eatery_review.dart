/// A single user review for an eatery.
class EateryReview {
  const EateryReview({
    required this.id,
    required this.reviewerName,
    required this.rating,
    required this.timeAgo,
    this.comment,
  });

  final String id;
  final String reviewerName;

  /// Star rating out of 5.
  final double rating;

  /// Relative time string, e.g. "1 day ago".
  final String timeAgo;

  /// Optional text body of the review.
  final String? comment;
}
