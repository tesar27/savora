/// A single redeemable deal offered by an eatery (e.g. "2-for-1 pasta").
///
/// **Data-layer note**: a future `EateryDealEntity` (Isar) and `EateryDealDto`
/// (Supabase JSON) will map to/from this via repository implementations;
/// the UI only ever sees [EateryDeal].
class EateryDeal {
  const EateryDeal({
    required this.id,
    required this.title,
    required this.savingsLabel,
    required this.validityDays,
    required this.locationType,
    required this.description,
  });

  /// Stable unique identifier – UUID in production, slug in mock.
  final String id;

  /// Short deal name shown on cards, e.g. "2-for-1 Pasta".
  final String title;

  /// Human-readable savings, e.g. "~14 €".
  final String savingsLabel;

  /// How many days the deal is valid after redemption.
  final int validityDays;

  /// Where the deal is redeemable, e.g. "In-store".
  final String locationType;

  /// Full description shown on the deal card.
  final String description;
}
