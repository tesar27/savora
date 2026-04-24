import 'package:flutter/material.dart';

import '../../eatery/domain/models/eatery.dart';
import '../../eatery/domain/models/eatery_deal.dart';
import 'redeem_activation_screen.dart';

/// Step 1 of the redeem flow.
///
/// Shows a full-screen centred layout where the user rates their experience
/// (1–5 stars, required) and leaves an optional free-text comment before
/// continuing to the drag-to-confirm activation screen.
class RedeemRatingScreen extends StatefulWidget {
  const RedeemRatingScreen({
    required this.eatery,
    required this.deal,
    super.key,
  });

  final Eatery eatery;
  final EateryDeal deal;

  @override
  State<RedeemRatingScreen> createState() => _RedeemRatingScreenState();
}

class _RedeemRatingScreenState extends State<RedeemRatingScreen> {
  int _starRating = 0; // 0 = unset, 1–5 = selected
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_starRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a star rating to continue.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => RedeemActivationScreen(
          eatery: widget.eatery,
          deal: widget.deal,
          userRating: _starRating.toDouble(),
          userComment: _commentController.text.trim().isEmpty
              ? null
              : _commentController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Rate Your Experience',
          style: tt.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1C1F2D),
          ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 32),

                // ── Eatery mini-card ─────────────────────────────────────
                _EateryMiniCard(eatery: widget.eatery, deal: widget.deal),

                const SizedBox(height: 44),

                // ── "How was your visit?" ────────────────────────────────
                Text(
                  'How was your visit?',
                  textAlign: TextAlign.center,
                  style: tt.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1C1F2D),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your honest feedback helps others discover great deals.',
                  textAlign: TextAlign.center,
                  style: tt.bodyMedium?.copyWith(
                    color: const Color(0xFF8A8F9E),
                  ),
                ),

                const SizedBox(height: 36),

                // ── 5 large interactive stars ────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(5, (int i) {
                    final bool filled = i < _starRating;
                    return GestureDetector(
                      onTap: () => setState(() => _starRating = i + 1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 180),
                          transitionBuilder:
                              (Widget child, Animation<double> anim) =>
                                  ScaleTransition(scale: anim, child: child),
                          child: Icon(
                            filled
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            key: ValueKey<bool>(filled),
                            size: 52,
                            color: filled
                                ? const Color(0xFF4BE289)
                                : const Color(0xFFD8D8D8),
                          ),
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 36),

                // ── Optional comment ─────────────────────────────────────
                TextField(
                  controller: _commentController,
                  maxLines: 4,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.multiline,
                  style: tt.bodyLarge?.copyWith(color: const Color(0xFF1C1F2D)),
                  decoration: InputDecoration(
                    hintText: 'Leave a comment… (optional)',
                    hintStyle: tt.bodyLarge?.copyWith(
                      color: const Color(0xFFB0B4C1),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF6F7FA),
                    contentPadding: const EdgeInsets.all(18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const Spacer(),

                // ── Next CTA ─────────────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: FilledButton(
                    onPressed: _onNext,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF4BE289),
                      foregroundColor: const Color(0xFF0E5C30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: tt.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0E5C30),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _EateryMiniCard extends StatelessWidget {
  const _EateryMiniCard({required this.eatery, required this.deal});

  final Eatery eatery;
  final EateryDeal deal;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7FA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: <Widget>[
          // Eatery thumbnail
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: Image.network(
              eatery.imageUrl,
              width: 88,
              height: 88,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext ctx, Object err, StackTrace? stack) =>
                  Container(
                    width: 88,
                    height: 88,
                    color: const Color(0xFFE0E0E0),
                    child: const Icon(
                      Icons.restaurant_rounded,
                      color: Color(0xFF9A9A9A),
                    ),
                  ),
            ),
          ),

          const SizedBox(width: 14),

          // Eatery name + deal title
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    eatery.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: tt.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1C1F2D),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    deal.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: tt.bodySmall?.copyWith(
                      color: const Color(0xFF5E6068),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0FAF0),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      deal.savingsLabel,
                      style: tt.labelSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0E6634),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 14),
        ],
      ),
    );
  }
}
