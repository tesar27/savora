import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

/// Generates and persistently stores a device-scoped anonymous user ID.
///
/// **Production upgrade path**:
/// When integrating Supabase auth:
/// ```dart
/// final user = Supabase.instance.client.auth.currentUser;
/// if (user != null) return user.id;
/// // Or: await client.auth.signInAnonymously() → user.id
/// ```
/// Anonymous sign-in via Supabase bridges seamlessly: when users later upgrade
/// to a full account, their bookings are merged under the same Supabase UID.
abstract final class AnonymousUserService {
  static const String _prefKey = 'savora_anon_user_id';

  /// Returns the persisted anonymous user ID, generating one on first call.
  ///
  /// The returned string is a standard RFC-4122 UUID v4, compatible with
  /// Supabase's `uuid` column type.
  static Future<String> ensureUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? existing = prefs.getString(_prefKey);
    if (existing != null && existing.isNotEmpty) return existing;

    final String newId = _uuidV4();
    await prefs.setString(_prefKey, newId);
    return newId;
  }

  // ── RFC-4122 UUID v4 — no external package needed ────────────────────────

  static String _uuidV4() {
    final Random rng = Random.secure();
    final List<int> bytes =
        List<int>.generate(16, (_) => rng.nextInt(256));

    // Set version bits (version 4)
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    // Set variant bits (variant 1)
    bytes[8] = (bytes[8] & 0x3f) | 0x80;

    final StringBuffer buf = StringBuffer();
    for (int i = 0; i < 16; i++) {
      if (i == 4 || i == 6 || i == 8 || i == 10) buf.write('-');
      buf.write(bytes[i].toRadixString(16).padLeft(2, '0'));
    }
    return buf.toString();
  }
}
