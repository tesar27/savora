import 'package:flutter/material.dart';

import '../../../core/di/repositories.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/services/anonymous_user_service.dart';
import '../../booking/data/repositories/local_booking_repository.dart';
import '../../booking/domain/models/booking.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  List<Booking> _bookings = <Booking>[];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
    LocalBookingRepository.version.addListener(_onVersionChange);
  }

  @override
  void dispose() {
    LocalBookingRepository.version.removeListener(_onVersionChange);
    super.dispose();
  }

  void _onVersionChange() => _load();

  Future<void> _load() async {
    final String userId = await AnonymousUserService.ensureUserId();
    final List<Booking> bookings =
        await Repositories.bookings.findAll(userId: userId);
    if (mounted) {
      setState(() {
        _bookings = bookings;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations t = AppLocalizations.of(context);
    final TextTheme tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // ── Header ────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
              child: Text(
                t.bookingsTitle,
                style: tt.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1C1F2D),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ── Body ──────────────────────────────────────────────────────
            Expanded(
              child: _loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF4BE289),
                      ),
                    )
                  : _bookings.isEmpty
                      ? _EmptyState(tt: tt)
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                          itemCount: _bookings.length,
                          separatorBuilder: (BuildContext ctx, int i) =>
                              const SizedBox(height: 16),
                          itemBuilder: (BuildContext context, int index) =>
                              _BookingCard(booking: _bookings[index]),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Empty state
// ─────────────────────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.tt});

  final TextTheme tt;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(
              Icons.receipt_long_rounded,
              size: 72,
              color: Color(0xFFD8D8D8),
            ),
            const SizedBox(height: 20),
            Text(
              'No bookings yet',
              style: tt.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1C1F2D),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Redeem a deal at an eatery and it will appear here.',
              textAlign: TextAlign.center,
              style: tt.bodyMedium?.copyWith(color: const Color(0xFF8A8F9E)),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Booking card (matches the Bookings.png design)
// ─────────────────────────────────────────────────────────────────────────────

class _BookingCard extends StatelessWidget {
  const _BookingCard({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.07),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // ── Eatery hero image ────────────────────────────────────────
          Image.network(
            booking.eateryImageUrl,
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder:
                (BuildContext ctx, Object err, StackTrace? stack) =>
                    Container(
                      height: 160,
                      color: const Color(0xFFECECEC),
                      child: const Icon(
                        Icons.restaurant_rounded,
                        size: 48,
                        color: Color(0xFF9A9A9A),
                      ),
                    ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // ── Eatery name + category ───────────────────────────
                Text(
                  booking.eateryName,
                  style: tt.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1C1F2D),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  booking.eateryCategory,
                  style: tt.bodySmall?.copyWith(
                    color: const Color(0xFF8A8F9E),
                  ),
                ),

                const SizedBox(height: 12),

                // ── Deal card ────────────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F7FA),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        booking.dealTitle,
                        style: tt.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1C1F2D),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: <Widget>[
                          _Chip(
                            label: booking.dealSavingsLabel,
                            color: const Color(0xFFE0FAF0),
                            textColor: const Color(0xFF0E6634),
                          ),
                          _Chip(
                            label: _formatDate(booking.redeemedAt),
                            color: const Color(0xFFF0F0F2),
                            textColor: const Color(0xFF5E6068),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ── User rating ──────────────────────────────────────
                if (booking.userRating != null) ...<Widget>[
                  const SizedBox(height: 14),
                  Text(
                    'Your Rating',
                    style: tt.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF8A8F9E),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: List<Widget>.generate(5, (int i) {
                      final bool filled =
                          i < (booking.userRating ?? 0).round();
                      return Icon(
                        filled
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        color: filled
                            ? const Color(0xFF4BE289)
                            : const Color(0xFFD8D8D8),
                        size: 22,
                      );
                    }),
                  ),
                  if (booking.userComment != null &&
                      booking.userComment!.isNotEmpty) ...<Widget>[
                    const SizedBox(height: 6),
                    Text(
                      '"${booking.userComment}"',
                      style: tt.bodySmall?.copyWith(
                        color: const Color(0xFF5E6068),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    final DateTime local = dt.toLocal();
    return '${local.day.toString().padLeft(2, '0')}.'
        '${local.month.toString().padLeft(2, '0')}.'
        '${local.year}';
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.color,
    required this.textColor,
  });

  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}

