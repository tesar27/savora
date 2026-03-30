import '../models/eatery.dart';

/// Contract that every eatery data source must satisfy.
///
/// Current implementation: [MockEateryRepository].
/// Production implementation: SupabaseEateryRepository (reads remote)
///                            + IsarEateryRepository (cache layer).
abstract interface class EateryRepository {
  /// Fetch a single eatery by its unique [id]. Returns null if not found.
  Future<Eatery?> getEatery(String id);

  /// Fetch a paged list of eateries, optionally filtered by [cityId] and/or
  /// [category]. [page] is zero-based, [pageSize] defaults to 20.
  Future<List<Eatery>> getEateries({
    String? cityId,
    String? category,
    int page = 0,
    int pageSize = 20,
  });
}
