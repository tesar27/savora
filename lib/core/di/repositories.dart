import 'package:savora/features/booking/data/repositories/local_booking_repository.dart';
import 'package:savora/features/booking/domain/repositories/booking_repository.dart';
import 'package:savora/features/eatery/data/repositories/mock_eatery_repository.dart';
import 'package:savora/features/eatery/domain/repositories/eatery_repository.dart';

/// Lightweight service locator for repository singletons.
///
/// **Mock phase**: all repositories point to in-memory / local implementations.
/// **Production swap**: replace the right-hand side values with production
/// implementations – no widget or screen code changes needed.
///
/// Example production setup:
/// ```dart
/// static final EateryRepository eateries =
///     SupabaseEateryRepository(cache: IsarEateryRepository(isar));
/// static final BookingRepository bookings =
///     SupabaseBookingRepository(cache: IsarBookingRepository(isar));
/// ```
abstract final class Repositories {
  static final EateryRepository eateries = MockEateryRepository();
  static final BookingRepository bookings = LocalBookingRepository();
}
