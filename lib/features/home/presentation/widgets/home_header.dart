import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Hello, Teresa!',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            style: textTheme.titleLarge?.copyWith(height: 1.25),
            children: const <InlineSpan>[
              TextSpan(text: 'Make your own food,\n'),
              TextSpan(text: 'stay at '),
              TextSpan(
                text: 'home',
                style: TextStyle(color: AppColors.accent),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
