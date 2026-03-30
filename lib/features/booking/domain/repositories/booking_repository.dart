import '../models/booking.dart';

/// Contract that all booking storage implementations must satisfy.
///
/// **Current implementation**: [LocalBookingRepository] (SharedPreferences).
/// **Production swap sequence**:
///   1. Add `isar_generator` + `build_runner` to `dev_dependencies`.
///   2. Create `BookingEntity` Isar collection mirroring [Booking] fields.
///   3. Create `IsarBookingRepository implements BookingRepository`.
///   4. Create `SupabaseBookingRepository implements BookingRepository` that
///      writes to the `bookings` Supabase table and keeps Isar in sync.
///   5. In [lib/core/di/repositories.dart] replace:
///        `LocalBookingRepository()`
///      with:
///        `SupabaseBookingRepository(cache: IsarBookingRepository(isar))`
///   No widget or screen code changes required.
abstract interface class BookingRepository {
  /// Persist a completed redemption.
  Future<void> save(Booking booking);

  /// All bookings for [userId], newest first.
  Future<List<Booking>> findAll({required String userId});

  /// Bookings for a specific eatery, newest first.
  Future<List<Booking>> findByEateryId({
    required String userId,
    required String eateryId,
  });

  /// Total number of completed redemptions.
  Future<int> countRedeemed({required String userId});

  /// Approximate Euro savings summed from [Booking.dealSavingsLabel] values.
  Future<double> totalSavingsEuros({required String userId});
}
