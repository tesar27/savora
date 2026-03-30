import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/booking.dart';
import '../../domain/repositories/booking_repository.dart';

/// SharedPreferences-backed booking store used during the mock / UI phase.
///
/// **Production swap:**
/// ```
/// Repositories.bookings = SupabaseBookingRepository(
///   cache: IsarBookingRepository(isar),
/// );
/// ```
/// Both production implementations will satisfy [BookingRepository], so no
/// widget code changes are needed.
///
/// **Isar note:** When isar_generator + build_runner are added, create
/// `BookingEntity` mirroring [Booking] fields (using `int` ms-since-epoch for
/// [DateTime], `@ignore` for computed fields if any).
class LocalBookingRepository implements BookingRepository {
  static const String _prefKey = 'savora_bookings_v1';

  // ── Listenable for live UI updates ───────────────────────────────────────

  /// Increments every time a booking is saved.  Widgets can listen to this to
  /// re-query without needing Riverpod or Bloc.
  static final ValueNotifier<int> version = ValueNotifier<int>(0);

  // ── Internal helpers ─────────────────────────────────────────────────────

  Future<List<Map<String, dynamic>>> _readAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> raw =
        prefs.getStringList(_prefKey) ?? <String>[];
    return raw
        .map((s) => jsonDecode(s) as Map<String, dynamic>)
        .toList();
  }

  Future<void> _writeAll(List<Map<String, dynamic>> records) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _prefKey,
      records.map(jsonEncode).toList(),
    );
  }

  // ── BookingRepository ────────────────────────────────────────────────────

  @override
  Future<void> save(Booking booking) async {
    final List<Map<String, dynamic>> all = await _readAll();
    all.add(booking.toJson());
    await _writeAll(all);
    version.value++; // notify listeners
  }

  @override
  Future<List<Booking>> findAll({required String userId}) async {
    final List<Map<String, dynamic>> all = await _readAll();
    return all
        .map(Booking.fromJson)
        .where((Booking b) => b.userId == userId)
        .toList()
        .reversed
        .toList(); // newest first
  }

  @override
  Future<List<Booking>> findByEateryId({
    required String userId,
    required String eateryId,
  }) async {
    final List<Booking> all = await findAll(userId: userId);
    return all.where((Booking b) => b.eateryId == eateryId).toList();
  }

  @override
  Future<int> countRedeemed({required String userId}) async {
    return (await findAll(userId: userId)).length;
  }

  @override
  Future<double> totalSavingsEuros({required String userId}) async {
    final List<Booking> all = await findAll(userId: userId);
    double total = 0.0;
    // Parse labels like "~14 €", "~8 €", "€30" etc.
    for (final Booking b in all) {
      final RegExpMatch? match =
          RegExp(r'(\d+(?:\.\d+)?)').firstMatch(b.dealSavingsLabel);
      if (match != null) {
        total += double.tryParse(match.group(0)!) ?? 0.0;
      }
    }
    return total;
  }
}
