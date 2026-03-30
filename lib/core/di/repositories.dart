import 'package:savora/features/eatery/data/repositories/mock_eatery_repository.dart';
import 'package:savora/features/eatery/domain/repositories/eatery_repository.dart';

/// Lightweight service locator for repository singletons.
///
/// **Mock phase**: all repositories point to in-memory implementations.
/// **Production swap**: replace the right-hand side values with
/// `SupabaseEateryRepository(cache: IsarEateryRepository())` – no widget
/// or screen code changes needed.
abstract final class Repositories {
  static final EateryRepository eateries = MockEateryRepository();
}
