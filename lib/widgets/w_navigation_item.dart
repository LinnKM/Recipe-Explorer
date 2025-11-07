import 'package:flutter/material.dart';
import 'package:recipe_explorer/Colors/app_colors.dart';
import 'package:recipe_explorer/app_enum.dart';

class NavigationItemWidget extends StatelessWidget {
  final int selectedIndex;
  final Navigation navigationitem;
  final VoidCallback onTap;

  const NavigationItemWidget({
    super.key,
    required this.selectedIndex,
    required this.navigationitem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedIndex == navigationitem.index;

    return InkWell(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: AnimatedScale(
          duration: Duration(milliseconds: 200),
          curve: Curves.decelerate,
          scale: isSelected ? 1.3 : 1,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 10),
            child: Icon(
              isSelected
                  ? navigationitem.filledIcon
                  : navigationitem.outlinedIcon,
              size: 24,
              color: isSelected ? Colors.black : AppColors.textSecond,
            ),
          ),
        ),
      ),
    );
  }
}
