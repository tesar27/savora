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
      height: 82,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 12),
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
                  height: 42,
                  width: 64,
                  decoration: BoxDecoration(
                    color: selected ? AppColors.accent : AppColors.chip,
                    borderRadius: BorderRadius.circular(21),
                  ),
                  child: Icon(
                    category.icon,
                    color: AppColors.textPrimary,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  category.label,
                  style: textTheme.bodySmall?.copyWith(
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
