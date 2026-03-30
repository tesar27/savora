import 'eatery_deal.dart';
import 'eatery_review.dart';
import 'opening_hours.dart';

/// Central domain model for an eatery – restaurant, café, bar, doner shop, etc.
///
/// **Three-layer architecture**
/// ┌─────────────────────────────────────────────┐
/// │  UI              ← Eatery (this class)       │
/// │  Repository      → EateryDto (Supabase JSON) │
/// │  Local cache     → EateryEntity (Isar)       │
/// └─────────────────────────────────────────────┘
/// Swap repository implementations without touching any widget.
class Eatery {
  const Eatery({
    required this.id,
    required this.name,
    required this.category,
    required this.rating,
    required this.ratingCount,
    required this.reviewCount,
    required this.distance,
    required this.imageUrl,
    required this.address,
    required this.city,
    required this.deals,
    required this.reviews,
    required this.openingHours,
    this.phone,
    this.rank,
    this.redeemedText,
  });

  /// Stable UUID in production; kebab-case slug in mock.
  final String id;

  /// Display name, e.g. "L'Osteria Freiburg Ramparts".
  final String name;

  /// Comma-separated cuisine / type, e.g. "Italian, Pizza, Pasta".
  final String category;

  final double rating;
  final int ratingCount;
  final int reviewCount;

  /// Human-readable distance from the user's city, e.g. "1.2 km".
  final String distance;

  final String imageUrl;
  final String address;
  final String city;
  final String? phone;

  /// Feed-rank label, e.g. "#1". Null for unranked eateries.
  final String? rank;

  /// Heat label shown on the card image, e.g. "3.8k+ redeemed".
  final String? redeemedText;

  final List<EateryDeal> deals;
  final List<EateryReview> reviews;
  final List<OpeningHours> openingHours;

  /// Convenience: deal titles used as quick tags on the feed card.
  List<String> get tags => deals.map((d) => d.title).toList();
}
