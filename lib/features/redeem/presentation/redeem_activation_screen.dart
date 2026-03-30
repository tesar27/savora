import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../app/navigation/main_scaffold.dart';
import '../../../core/di/repositories.dart';
import '../../../core/services/anonymous_user_service.dart';
import '../../booking/domain/models/booking.dart';
import '../../eatery/domain/models/eatery.dart';
import '../../eatery/domain/models/eatery_deal.dart';

/// Step 2 of the redeem flow.
///
/// The user swipes a thumb from left to right across a full-width track
/// (similar to the iPhone "slide to power off" gesture) to confirm the
/// deal redemption.
///
/// On completion:
/// - Booking is saved locally via [Repositories.bookings].
/// - An animated congratulations overlay replaces the screen content.
/// - Tapping Done switches to the Bookings tab and pops back to root.
class RedeemActivationScreen extends StatefulWidget {
  const RedeemActivationScreen({
    required this.eatery,
    required this.deal,
    required this.userRating,
    required this.userComment,
    super.key,
  });

  final Eatery eatery;
  final EateryDeal deal;
  final double? userRating;
  final String? userComment;

  @override
  State<RedeemActivationScreen> createState() => _RedeemActivationScreenState();
}

class _RedeemActivationScreenState extends State<RedeemActivationScreen>
    with TickerProviderStateMixin {
  bool _redeemed = false;
  late AnimationController _confettiController;
  late AnimationController _checkController;
  late Animation<double> _checkScale;

  @override
  void initState() {
    super.initState();
    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _checkScale = CurvedAnimation(
      parent: _checkController,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _checkController.dispose();
    super.dispose();
  }

  Future<void> _onSlideComplete() async {
    try {
      // 1. Persist booking
      final String userId = await AnonymousUserService.ensureUserId();
      final Booking booking = Booking(
        id: _uuid(),
        userId: userId,
        eateryId: widget.eatery.id,
        eateryName: widget.eatery.name,
        eateryImageUrl: widget.eatery.imageUrl,
        eateryCategory: widget.eatery.category,
        dealId: widget.deal.id,
        dealTitle: widget.deal.title,
        dealSavingsLabel: widget.deal.savingsLabel,
        redeemedAt: DateTime.now().toUtc(),
        userRating: widget.userRating,
        userComment: widget.userComment,
      );
      await Repositories.bookings.save(booking);

      // 2. Show congratulations overlay
      if (!mounted) return;
      setState(() => _redeemed = true);
      _confettiController.forward();
      _checkController.forward();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not save booking: $e'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      // Re-throw so the slider can reset itself for a retry
      rethrow;
    }
  }

  String _uuid() {
    final math.Random rng = math.Random.secure();
    final List<int> bytes = List<int>.generate(16, (_) => rng.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    final StringBuffer buf = StringBuffer();
    for (int i = 0; i < 16; i++) {
      if (i == 4 || i == 6 || i == 8 || i == 10) buf.write('-');
      buf.write(bytes[i].toRadixString(16).padLeft(2, '0'));
    }
    return buf.toString();
  }

  void _onDone() {
    // Switch bottom nav to Bookings tab (index 3) then pop all screens
    MainScaffold.switchTo(3);
    Navigator.of(context).popUntil((Route<dynamic> r) => r.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> anim) =>
            FadeTransition(opacity: anim, child: child),
        child: _redeemed
            ? _CongratsView(
                key: const ValueKey<String>('congrats'),
                deal: widget.deal,
                checkScale: _checkScale,
                confettiController: _confettiController,
                onDone: _onDone,
              )
            : _ActivationView(
                key: const ValueKey<String>('activation'),
                eatery: widget.eatery,
                deal: widget.deal,
                onSlideComplete: _onSlideComplete,
              ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Activation (pre-redeem) view
// ─────────────────────────────────────────────────────────────────────────────

class _ActivationView extends StatelessWidget {
  const _ActivationView({
    required this.eatery,
    required this.deal,
    required this.onSlideComplete,
    super.key,
  });

  final Eatery eatery;
  final EateryDeal deal;
  final Future<void> Function() onSlideComplete;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    final double safeTop = MediaQuery.of(context).padding.top;

    return Stack(
      children: <Widget>[
        // ── Close button ─────────────────────────────────────────────────
        Positioned(
          top: safeTop + 12,
          left: 16,
          child: IconButton(
            icon: const Icon(Icons.close_rounded, color: Color(0xFF1C1F2D)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),

        // ── Main content ─────────────────────────────────────────────────
        Padding(
          padding: EdgeInsets.fromLTRB(28, safeTop + 72, 28, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Deal icon/illustration
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: const Color(0xFFECFBF4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.local_offer_rounded,
                  size: 52,
                  color: Color(0xFF4BE289),
                ),
              ),
              const SizedBox(height: 28),

              // Eatery name
              Text(
                eatery.name,
                textAlign: TextAlign.center,
                style: tt.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF5E6068),
                ),
              ),
              const SizedBox(height: 6),

              // Deal title
              Text(
                deal.title,
                textAlign: TextAlign.center,
                style: tt.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1C1F2D),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),

              // Savings badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0FAF0),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  deal.savingsLabel,
                  style: tt.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0E6634),
                  ),
                ),
              ),

              const Spacer(),

              // Instruction
              Text(
                'Swipe to confirm your redemption',
                textAlign: TextAlign.center,
                style: tt.bodyLarge?.copyWith(
                  color: const Color(0xFF8A8F9E),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),

              // Drag slider
              _SwipeSlider(onCompleted: onSlideComplete),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Swipe-to-redeem slider (iPhone swipe-to-power-off style)
// ─────────────────────────────────────────────────────────────────────────────

class _SwipeSlider extends StatefulWidget {
  const _SwipeSlider({required this.onCompleted});

  final Future<void> Function() onCompleted;

  @override
  State<_SwipeSlider> createState() => _SwipeSliderState();
}

class _SwipeSliderState extends State<_SwipeSlider>
    with SingleTickerProviderStateMixin {
  static const double _trackHeight = 72.0;
  static const double _thumbSize = 58.0;
  static const double _trackPadding = 7.0;

  double _thumbOffset = 0.0;
  double _maxOffset = 0.0;
  bool _triggered = false;

  late AnimationController _snapBack;

  @override
  void initState() {
    super.initState();
    _snapBack = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
  }

  @override
  void dispose() {
    _snapBack.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_triggered) return;
    _snapBack.stop();
    setState(() {
      _thumbOffset = (_thumbOffset + details.delta.dx).clamp(0.0, _maxOffset);
    });
    if (_thumbOffset >= _maxOffset * 0.88) {
      _triggered = true;
      widget.onCompleted().catchError((Object e) {
        // Save failed — reset slider so the user can try again
        if (mounted) {
          setState(() {
            _triggered = false;
            _thumbOffset = 0;
          });
        }
      });
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_triggered) return;
    final double startOffset = _thumbOffset;
    final Animation<double> anim = Tween<double>(
      begin: startOffset,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _snapBack, curve: Curves.easeOut));
    anim.addListener(() {
      if (mounted) setState(() => _thumbOffset = anim.value);
    });
    _snapBack.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        _maxOffset = constraints.maxWidth - _thumbSize - _trackPadding * 2;

        final double progress = _maxOffset > 0
            ? (_thumbOffset / _maxOffset).clamp(0.0, 1.0)
            : 0.0;

        return GestureDetector(
          onHorizontalDragUpdate: _handleDragUpdate,
          onHorizontalDragEnd: _handleDragEnd,
          child: Container(
            height: _trackHeight,
            decoration: BoxDecoration(
              color: Color.lerp(
                const Color(0xFFF0F0F2),
                const Color(0xFFDEF9EC),
                progress,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                // Label fades out as thumb moves right
                Center(
                  child: Opacity(
                    opacity: (1.0 - progress * 2.5).clamp(0.0, 1.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(width: _thumbSize),
                        Text(
                          'Slide to Redeem',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: const Color(0xFF9A9A9A),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Thumb circle
                Positioned(
                  left: _trackPadding + _thumbOffset,
                  child: Container(
                    width: _thumbSize,
                    height: _thumbSize,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4BE289),
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: const Color(
                            0xFF4BE289,
                          ).withValues(alpha: 0.35),
                          blurRadius: 14,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Congratulations view (post-redeem)
// ─────────────────────────────────────────────────────────────────────────────

class _CongratsView extends StatelessWidget {
  const _CongratsView({
    required this.deal,
    required this.checkScale,
    required this.confettiController,
    required this.onDone,
    super.key,
  });

  final EateryDeal deal;
  final Animation<double> checkScale;
  final AnimationController confettiController;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;

    return Stack(
      children: <Widget>[
        // ── Confetti layer ───────────────────────────────────────────────
        Positioned.fill(
          child: AnimatedBuilder(
            animation: confettiController,
            builder: (BuildContext context, Widget? child) => CustomPaint(
              painter: _ConfettiPainter(
                progress: confettiController.value,
                particles: _ConfettiPainter.defaultParticles,
              ),
            ),
          ),
        ),

        // ── Center content ───────────────────────────────────────────────
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: <Widget>[
                const Spacer(flex: 2),

                // Animated checkmark
                ScaleTransition(
                  scale: checkScale,
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      color: const Color(0xFFECFBF4),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xFF4BE289),
                      size: 90,
                    ),
                  ),
                ),

                const SizedBox(height: 36),

                Text(
                  '🎉 Deal Redeemed!',
                  textAlign: TextAlign.center,
                  style: tt.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF1C1F2D),
                    height: 1.1,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  deal.title,
                  textAlign: TextAlign.center,
                  style: tt.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4BE289),
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  'Enjoy your savings! Show this to the staff\nwhen you arrive at the eatery.',
                  textAlign: TextAlign.center,
                  style: tt.bodyLarge?.copyWith(
                    color: const Color(0xFF8A8F9E),
                    height: 1.5,
                  ),
                ),

                const Spacer(flex: 3),

                // Done button
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: FilledButton(
                    onPressed: onDone,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF4BE289),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Text(
                      'Done',
                      style: tt.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0E5C30),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Confetti particle painter
// ─────────────────────────────────────────────────────────────────────────────

class _ConfettiParticle {
  const _ConfettiParticle({
    required this.x,
    required this.speed,
    required this.phase,
    required this.size,
    required this.color,
  });

  final double x; // 0..1 (fraction of canvas width)
  final double speed; // 0.4..1.0
  final double phase; // horizontal sine-wave phase (radians)
  final double size; // rect short side in pixels
  final Color color;
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter({required this.progress, required this.particles});

  final double progress; // 0..1
  final List<_ConfettiParticle> particles;

  static final List<_ConfettiParticle> defaultParticles = _generate(count: 70);

  static List<_ConfettiParticle> _generate({required int count}) {
    const List<Color> palette = <Color>[
      Color(0xFF4BE289),
      Color(0xFFFFD166),
      Color(0xFFEF476F),
      Color(0xFF118AB2),
      Color(0xFFFFB347),
      Color(0xFFB5EAD7),
      Color(0xFFFF6B6B),
    ];
    final math.Random rng = math.Random(42);
    return List<_ConfettiParticle>.generate(count, (int i) {
      return _ConfettiParticle(
        x: rng.nextDouble(),
        speed: 0.35 + rng.nextDouble() * 0.65,
        phase: rng.nextDouble() * 2 * math.pi,
        size: 6.0 + rng.nextDouble() * 8.0,
        color: palette[rng.nextInt(palette.length)],
      );
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0) return;
    final Paint paint = Paint();
    for (final _ConfettiParticle p in particles) {
      final double t = (progress * p.speed * 2.8) % 1.0;
      final double y = t * size.height;
      final double x =
          p.x * size.width + math.sin(progress * math.pi * 4 + p.phase) * 24;

      final double fade = t > 0.75 ? (1.0 - t) / 0.25 : 1.0;
      paint.color = p.color.withValues(alpha: fade.clamp(0.0, 1.0));

      final Rect rect = Rect.fromCenter(
        center: Offset(x, y),
        width: p.size,
        height: p.size * 1.6,
      );

      canvas
        ..save()
        ..translate(x, y)
        ..rotate(progress * p.speed * 5.0)
        ..translate(-x, -y)
        ..drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(2)),
          paint,
        )
        ..restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => old.progress != progress;
}
