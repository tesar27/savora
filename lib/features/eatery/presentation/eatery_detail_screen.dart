import 'package:flutter/material.dart';

import '../domain/models/eatery.dart';
import '../domain/models/opening_hours.dart';
import '../../redeem/presentation/redeem_rating_screen.dart';
import 'widgets/eatery_deal_card.dart';
import 'widgets/eatery_review_tile.dart';

/// Full-screen eatery detail page.
///
/// **Scroll behaviour**
/// - Scrolling *down*: the white content sheet slides up and covers the hero
///   image progressively.
/// - Overscrolling *up* (pull-to-refresh gesture): the hero image scales up
///   slightly (iOS-style zoom), then springs back automatically when released.
class EateryDetailScreen extends StatefulWidget {
  const EateryDetailScreen({required this.eatery, super.key});

  final Eatery eatery;

  @override
  State<EateryDetailScreen> createState() => _EateryDetailScreenState();
}

class _EateryDetailScreenState extends State<EateryDetailScreen> {
  /// Height of the fixed hero image.
  static const double _kImageHeight = 320.0;

  /// How far from the top the scrollable content starts.
  /// Setting this < _kImageHeight creates the initial overlap with the image.
  static const double _kScrollOffset = 278.0;

  double _imageScale = 1.0;
  bool _isOverscrolling = false;

  bool _onScroll(ScrollNotification notification) {
    final double pixels = notification.metrics.pixels;
    if (pixels < 0) {
      final double scale = 1.0 + (-pixels / 400).clamp(0.0, 0.12);
      if (_imageScale != scale || !_isOverscrolling) {
        setState(() {
          _isOverscrolling = true;
          _imageScale = scale;
        });
      }
    } else if (_isOverscrolling || _imageScale != 1.0) {
      setState(() {
        _isOverscrolling = false;
        _imageScale = 1.0;
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final double safeTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          // ── 1. Hero image (fixed, zooms on overscroll) ──────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedScale(
              scale: _imageScale,
              duration: _isOverscrolling
                  ? Duration.zero
                  : const Duration(milliseconds: 300),
              alignment: Alignment.topCenter,
              curve: Curves.easeOut,
              child: Image.network(
                widget.eatery.imageUrl,
                height: _kImageHeight,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder:
                    (BuildContext context, Object error, StackTrace? stack) =>
                        Container(
                          height: _kImageHeight,
                          color: const Color(0xFFECECEC),
                          child: const Icon(
                            Icons.restaurant_rounded,
                            size: 72,
                            color: Color(0xFF9A9A9A),
                          ),
                        ),
              ),
            ),
          ),

          // ── 2. Scrollable content sheet ─────────────────────────────────
          NotificationListener<ScrollNotification>(
            onNotification: _onScroll,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Column(
                children: <Widget>[
                  // Transparent gap that sits behind the image
                  const SizedBox(height: _kScrollOffset),
                  _ContentSheet(eatery: widget.eatery),
                ],
              ),
            ),
          ),

          // ── 3. Floating back button ─────────────────────────────────────
          Positioned(
            top: safeTop + 12,
            left: 16,
            child: _FloatingButton(
              icon: Icons.arrow_back_ios_new_rounded,
              onTap: () => Navigator.of(context).pop(),
            ),
          ),

          // ── 4. Floating bookmark button ──────────────────────────────────
          Positioned(
            top: safeTop + 12,
            right: 16,
            child: _FloatingButton(
              icon: Icons.bookmark_border_rounded,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Content sheet
// ─────────────────────────────────────────────────────────────────────────────

class _ContentSheet extends StatelessWidget {
  const _ContentSheet({required this.eatery});

  final Eatery eatery;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final TextTheme tt = Theme.of(context).textTheme;

    return Container(
      constraints: BoxConstraints(
        minHeight: screenHeight - _EateryDetailScreenState._kScrollOffset,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHandle(),
          _buildHeader(context, tt),
          _buildInfoRow(tt),
          _buildDeals(context, tt),
          _buildReviews(context, tt),
          _buildLocation(context, tt),
          _buildContact(tt),
          _buildOpeningHours(tt),
          _buildReportButton(context, tt),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  // ── Drag handle ────────────────────────────────────────────────────────────

  Widget _buildHandle() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 4),
        child: Container(
          width: 40,
          height: 5,
          decoration: BoxDecoration(
            color: const Color(0xFFD5D5D5),
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
    );
  }

  // ── Header: name + category + rating pill ─────────────────────────────────

  Widget _buildHeader(BuildContext context, TextTheme tt) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  eatery.name,
                  style: tt.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1C1F2D),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  eatery.category,
                  style: tt.bodyLarge?.copyWith(color: const Color(0xFF7C7D89)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF7C75C),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(
                  Icons.star_rounded,
                  size: 18,
                  color: Color(0xFF131313),
                ),
                const SizedBox(width: 4),
                Text(
                  eatery.rating.toStringAsFixed(1),
                  style: tt.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF131313),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Info pills row ────────────────────────────────────────────────────────

  Widget _buildInfoRow(TextTheme tt) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Wrap(
        spacing: 10,
        runSpacing: 8,
        children: <Widget>[
          _InfoPill(icon: Icons.place_outlined, value: eatery.distance),
          _InfoPill(
            icon: Icons.chat_bubble_outline_rounded,
            value: '${eatery.reviewCount} reviews',
          ),
          _InfoPill(
            icon: Icons.local_offer_outlined,
            value: '${eatery.deals.length} deals',
          ),
        ],
      ),
    );
  }

  // ── Deals ─────────────────────────────────────────────────────────────────

  Widget _buildDeals(BuildContext context, TextTheme tt) {
    if (eatery.deals.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Deals',
            style: tt.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1C1F2D),
            ),
          ),
          const SizedBox(height: 14),
          ...eatery.deals.map(
            (deal) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: EateryDealCard(
                deal: deal,
                onRedeem: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => RedeemRatingScreen(
                      eatery: eatery,
                      deal: deal,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Reviews ───────────────────────────────────────────────────────────────

  Widget _buildReviews(BuildContext context, TextTheme tt) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Reviews',
            style: tt.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1C1F2D),
            ),
          ),
          const SizedBox(height: 14),
          // Aggregate rating
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                eatery.rating.toStringAsFixed(1).replaceAll('.', ','),
                style: tt.displayMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1C1F2D),
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: List<Widget>.generate(5, (int i) {
                      final bool filled = i < eatery.rating.floor();
                      final bool half =
                          i == eatery.rating.floor() &&
                          eatery.rating % 1 >= 0.5;
                      return Icon(
                        half
                            ? Icons.star_half_rounded
                            : filled
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        color: const Color(0xFF42D88A),
                        size: 24,
                      );
                    }),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${eatery.ratingCount} ratings  |  ${eatery.reviewCount} reviews',
                    style: tt.bodySmall?.copyWith(
                      color: const Color(0xFF9A9AAA),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          ...eatery.reviews.map((review) => EateryReviewTile(review: review)),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                side: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              child: Text(
                'All Reviews (${eatery.reviewCount})',
                style: tt.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Location ──────────────────────────────────────────────────────────────

  Widget _buildLocation(BuildContext context, TextTheme tt) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(
                Icons.place_rounded,
                color: Color(0xFF1C1F2D),
                size: 24,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Location',
                    style: tt.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    eatery.address,
                    style: tt.bodyMedium?.copyWith(
                      color: const Color(0xFF7C7D89),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: _MapPlaceholder(address: eatery.address),
          ),
        ],
      ),
    );
  }

  // ── Contact ───────────────────────────────────────────────────────────────

  Widget _buildContact(TextTheme tt) {
    if (eatery.phone == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(
                Icons.phone_outlined,
                size: 24,
                color: Color(0xFF1C1F2D),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Contact',
                    style: tt.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    eatery.phone!,
                    style: tt.bodyMedium?.copyWith(
                      color: const Color(0xFF7C7D89),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Opening hours ─────────────────────────────────────────────────────────

  Widget _buildOpeningHours(TextTheme tt) {
    if (eatery.openingHours.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(
                Icons.access_time_rounded,
                size: 24,
                color: Color(0xFF1C1F2D),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Opening Hours',
                      style: tt.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...eatery.openingHours.map(
                      (OpeningHours h) => Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              h.day,
                              style: tt.bodyMedium?.copyWith(
                                color: const Color(0xFF7C7D89),
                              ),
                            ),
                            Text(
                              h.isClosed ? 'Closed' : '${h.open} – ${h.close}',
                              style: tt.bodyMedium?.copyWith(
                                color: h.isClosed
                                    ? Colors.redAccent
                                    : const Color(0xFF1C1F2D),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Report button ─────────────────────────────────────────────────────────

  Widget _buildReportButton(BuildContext context, TextTheme tt) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Center(
        child: TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.chat_bubble_outline_rounded, size: 18),
          label: const Text('Report a Problem'),
          style: TextButton.styleFrom(foregroundColor: const Color(0xFF9A9AAA)),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared sub-widgets
// ─────────────────────────────────────────────────────────────────────────────

class _FloatingButton extends StatelessWidget {
  const _FloatingButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 3,
      shadowColor: Colors.black26,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, size: 20, color: const Color(0xFF1C1F2D)),
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.value});

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 15, color: const Color(0xFF1C1F2D)),
          const SizedBox(width: 6),
          Text(
            value,
            style: tt.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1C1F2D),
            ),
          ),
        ],
      ),
    );
  }
}

/// A stylised map placeholder rendered with a simple CustomPainter.
/// In production, swap for `flutter_map` or `google_maps_flutter`.
class _MapPlaceholder extends StatelessWidget {
  const _MapPlaceholder({required this.address});

  final String address;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CustomPaint(painter: _MapGridPainter()),
          Center(
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(color: Colors.black26, blurRadius: 6),
                ],
              ),
              child: const Icon(
                Icons.place_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFEEF0F3);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bg);

    final Paint grid = Paint()
      ..color = const Color(0xFFDDE3EC)
      ..strokeWidth = 0.8;

    for (double y = 25; y < size.height; y += 28) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    for (double x = 30; x < size.width; x += 38) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }

    final Paint road = Paint()
      ..color = Colors.white
      ..strokeWidth = 7;
    canvas.drawLine(
      Offset(size.width * 0.35, 0),
      Offset(size.width * 0.35, size.height),
      road,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.48),
      Offset(size.width, size.height * 0.48),
      road,
    );
  }

  @override
  bool shouldRepaint(_MapGridPainter oldDelegate) => false;
}
