import 'package:flutter/material.dart';

import '../../domain/models/eatery_deal.dart';

/// Card displaying a single redeemable deal inside the eatery detail screen.
class EateryDealCard extends StatelessWidget {
  const EateryDealCard({required this.deal, required this.onRedeem, super.key});

  final EateryDeal deal;
  final VoidCallback onRedeem;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  deal.title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1C1F2D),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.info_outline_rounded,
                size: 20,
                color: Color(0xFF9A9AAA),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: <Widget>[
              _DealChip(
                icon: Icons.card_giftcard_rounded,
                label: deal.savingsLabel,
              ),
              _DealChip(
                icon: Icons.sync_rounded,
                label: '${deal.validityDays} days',
              ),
              _DealChip(icon: Icons.place_outlined, label: deal.locationType),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            deal.description,
            style: textTheme.bodySmall?.copyWith(
              color: const Color(0xFF7C7D89),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onRedeem,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4BE289),
                foregroundColor: const Color(0xFF0E2437),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: Text(
                'Redeem Deal',
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0E2437),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DealChip extends StatelessWidget {
  const _DealChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: const Color(0xFF1C1F2D)),
          const SizedBox(width: 5),
          Text(
            label,
            style: textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1C1F2D),
            ),
          ),
        ],
      ),
    );
  }
}
