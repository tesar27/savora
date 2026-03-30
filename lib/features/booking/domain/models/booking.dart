/// A completed deal redemption made by a user at an eatery.
///
/// **Three-layer architecture**
/// ┌──────────────────────────────────────────────────────────┐
/// │  UI                ← Booking (this class, domain model)  │
/// │  Remote repository → bookings table in Supabase          │
/// │  Local cache       → BookingEntity (Isar collection)     │
/// └──────────────────────────────────────────────────────────┘
///
/// Production storage note:
/// - `userId` is either an anonymous Supabase auth UID or a full user UID.
///   When the user upgrades from anonymous → authenticated, Supabase merges
///   the identity so the same `userId` continues to work.
/// - Isar entity `@Collection() BookingEntity` will mirror these fields with
///   types that Isar supports natively (int millisecondsSinceEpoch for dates).
///   Add `isar_generator` + `build_runner` to dev_dependencies when switching.
class Booking {
  const Booking({
    required this.id,
    required this.userId,
    required this.eateryId,
    required this.eateryName,
    required this.eateryImageUrl,
    required this.eateryCategory,
    required this.dealId,
    required this.dealTitle,
    required this.dealSavingsLabel,
    required this.redeemedAt,
    this.userRating,
    this.userComment,
  });

  /// RFC-4122 UUID v4; generated client-side for offline-first support.
  final String id;

  /// Supabase auth UID (or local anonymous UUID before sign-in).
  final String userId;

  /// Matches [Eatery.id] used as foreign key in the `eateries` Supabase table.
  final String eateryId;

  final String eateryName;
  final String eateryImageUrl;
  final String eateryCategory;

  /// Matches [EateryDeal.id].
  final String dealId;
  final String dealTitle;

  /// Human-readable label from the deal card, e.g. "~14 €".
  final String dealSavingsLabel;

  /// UTC timestamp of redemption.
  final DateTime redeemedAt;

  /// Star rating 1–5 given by the user at redemption time.  Nullable if skipped.
  final double? userRating;

  /// Optional freetext comment left by the user.
  final String? userComment;

  // ── Serialisation (used by LocalBookingRepository / Supabase DTO) ─────────

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'userId': userId,
        'eateryId': eateryId,
        'eateryName': eateryName,
        'eateryImageUrl': eateryImageUrl,
        'eateryCategory': eateryCategory,
        'dealId': dealId,
        'dealTitle': dealTitle,
        'dealSavingsLabel': dealSavingsLabel,
        'redeemedAt': redeemedAt.toUtc().toIso8601String(),
        'userRating': userRating,
        'userComment': userComment,
      };

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json['id'] as String,
        userId: json['userId'] as String,
        eateryId: json['eateryId'] as String,
        eateryName: json['eateryName'] as String,
        eateryImageUrl: json['eateryImageUrl'] as String,
        eateryCategory: json['eateryCategory'] as String,
        dealId: json['dealId'] as String,
        dealTitle: json['dealTitle'] as String,
        dealSavingsLabel: json['dealSavingsLabel'] as String,
        redeemedAt: DateTime.parse(json['redeemedAt'] as String),
        userRating: (json['userRating'] as num?)?.toDouble(),
        userComment: json['userComment'] as String?,
      );
}
