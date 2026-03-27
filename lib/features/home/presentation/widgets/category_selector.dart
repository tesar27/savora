import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../models/home_models.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    required this.categories,
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  final List<HomeCategory> categories;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 18),
        itemBuilder: (BuildContext context, int index) {
          final HomeCategory category = categories[index];
          final bool selected = selectedIndex == index;

          return GestureDetector(
            onTap: () => onSelected(index),
            child: Column(
              children: <Widget>[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: selected ? AppColors.accent : AppColors.chip,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    category.icon,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  category.label,
                  style: textTheme.bodyMedium?.copyWith(
                    color: selected
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
