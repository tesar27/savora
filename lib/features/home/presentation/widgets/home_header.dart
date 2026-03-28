import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({required this.cityName, this.onCityTap, super.key});

  final String cityName;
  final VoidCallback? onCityTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          onTap: onCityTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Row(
              children: <Widget>[
                Text(
                  cityName,
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF171A24),
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down_rounded, size: 22),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 40,
          width: 40,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded, size: 28),
            padding: EdgeInsets.zero,
            splashRadius: 20,
          ),
        ),
      ],
    );
  }
}
