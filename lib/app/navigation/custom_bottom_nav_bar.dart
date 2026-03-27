import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'nav_tab.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    required this.tabs,
    required this.currentIndex,
    required this.onSelected,
    super.key,
  });

  final List<NavTab> tabs;
  final int currentIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.subtleBorder)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              const double spacing = 6;
              final double totalSpacing = spacing * (tabs.length - 1);
              final double selectedWidth =
                  (constraints.maxWidth - totalSpacing - 48 * (tabs.length - 1))
                      .clamp(90, 108)
                      .toDouble();
              final double collapsedWidth = tabs.length == 1
                  ? constraints.maxWidth
                  : (constraints.maxWidth - totalSpacing - selectedWidth) /
                      (tabs.length - 1);

              return Row(
                children: List<Widget>.generate(tabs.length, (int index) {
                  final bool isSelected = index == currentIndex;
                  final NavTab tab = tabs[index];
                  final double itemWidth = isSelected
                      ? selectedWidth
                      : collapsedWidth;

                  return Padding(
                    padding: EdgeInsets.only(
                      right: index == tabs.length - 1 ? 0 : spacing,
                    ),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onSelected(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOutCubic,
                        width: itemWidth,
                        height: 42,
                        padding: EdgeInsets.symmetric(
                          horizontal: isSelected ? 8 : 0,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.accent
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(21),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              tab.icon,
                              color: isSelected
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                              size: 20,
                            ),
                            AnimatedSize(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeOutCubic,
                              child: isSelected
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth: itemWidth - 34,
                                        ),
                                        child: Text(
                                          tab.label,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme.bodySmall?.copyWith(
                                            color: AppColors.textPrimary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}
