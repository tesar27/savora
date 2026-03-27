import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({required this.cityName, super.key});

  final String cityName;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              cityName,
              style: textTheme.headlineMedium?.copyWith(
                fontSize: 52,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF171A24),
                letterSpacing: -1.6,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.keyboard_arrow_down_rounded, size: 28),
          ],
        ),
        SizedBox(
          height: 42,
          width: 42,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded, size: 32),
            padding: EdgeInsets.zero,
            splashRadius: 22,
          ),
        ),
      ],
    );
  }
}
