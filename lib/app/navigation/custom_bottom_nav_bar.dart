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
          child: Row(
            children: List<Widget>.generate(tabs.length, (int index) {
              final bool isSelected = index == currentIndex;
              final NavTab tab = tabs[index];

              return Expanded(
                flex: isSelected ? 14 : 10,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onSelected(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutCubic,
                    height: 42,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.symmetric(
                      horizontal: isSelected ? 8 : 0,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.accent : Colors.transparent,
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
                          size: 22,
                        ),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOutCubic,
                          child: isSelected
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      maxWidth: 74,
                                    ),
                                    child: Text(
                                      tab.label,
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.bodyMedium?.copyWith(
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
          ),
        ),
      ),
    );
  }
}
