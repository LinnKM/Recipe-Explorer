import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:recipe_explorer/Colors/app_colors.dart';
import 'package:recipe_explorer/controller/saved_recipe_controller.dart';
import 'package:recipe_explorer/model/recipe_model.dart';

class BookmarkButton extends StatelessWidget {
  final RecipeModel recipe;

  const BookmarkButton({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedRecipeController>(
      builder: (controller) {
        final isSaved = controller.savedIds.contains(recipe.id);
        return IconButton(
          icon: Icon(
            isSaved ? TablerIcons.bookmark_filled : TablerIcons.bookmark_plus,
            color: isSaved ? AppColors.primaryColor : Colors.grey,
          ),
          onPressed: () => controller.toggleSave(recipe),
        );
      },
    );
  }
}
