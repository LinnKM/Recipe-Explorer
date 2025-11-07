import 'package:flutter/material.dart';
import 'package:recipe_explorer/Colors/app_colors.dart';
import 'package:recipe_explorer/app_extension.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? customTitle;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? centerTitle;
  final bool? automaticallyImplyLeading;
  final PreferredSizeWidget? bottom;
  final EdgeInsetsGeometry? actionsPadding;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.centerTitle,
    this.automaticallyImplyLeading,
    this.customTitle,
    this.bottom,
    this.actionsPadding,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      shadowColor: Colors.black.withAlpha(0.3.toAlpha()),
      elevation: 3,
      actionsPadding: actionsPadding,
      centerTitle: centerTitle,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading ?? false,

      title:
          customTitle ??
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),

      actions: actions,

      bottom: bottom,
    );
  }

  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize.height ?? 0.0;
    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }
}
