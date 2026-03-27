import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search any recipe',
              hintStyle: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF8D8D8D)),
              prefixIcon: const Icon(Icons.search_rounded),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 46,
          width: 46,
          decoration: const BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: const Icon(Icons.tune_rounded, color: Color(0xFF565656)),
        ),
      ],
    );
  }
}
