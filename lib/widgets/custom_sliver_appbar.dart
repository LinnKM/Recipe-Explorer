import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:recipe_explorer/Colors/app_colors.dart';

class CustomSliverAppbar extends StatelessWidget {
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? centerTitle;

  const CustomSliverAppbar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.centerTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: Get.height * 0.09,
      pinned: true,
      backgroundColor: Colors.white,
      centerTitle: centerTitle,
      leading: leading,
      title: title,
      actions: actions,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }
}

// SliverAppBar(
//           toolbarHeight: Get.height * 0.09,
//           pinned: true,
//           backgroundColor: Colors.white,
//           title: Text(
//             'Recipe Explorer',
//             style: TextStyle(
//               color: AppColors.primaryColor,
//               fontSize: 25,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           actions: [
//             IconButton(
//               onPressed: () {
//                 Get.to(
//                   () => SearchRecipePage(),
//                   transition: Transition.leftToRight,
//                   duration: Duration(milliseconds: 200),
//                 );
//               },
//               icon: Icon(TablerIcons.search, color: AppColors.textSecond),
//             ),
//           ],
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black26,
//                   blurRadius: 4,
//                   offset: Offset(0, 2),
//                 ),
//               ],
//             ),
//           ),
//         ),
