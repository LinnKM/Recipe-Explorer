import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:recipe_explorer/Colors/app_colors.dart';
import 'package:recipe_explorer/app_extension.dart';
import 'package:recipe_explorer/controller/saved_recipe_controller.dart';
import 'package:recipe_explorer/view/recipe_detail_view.dart';
import 'package:recipe_explorer/widgets/w_cached_image.dart';
import 'package:recipe_explorer/widgets/w_custom_appbar.dart';

class SavedRecipePage extends StatefulWidget {
  const SavedRecipePage({super.key});

  @override
  State<SavedRecipePage> createState() => _SavedRecipePageState();
}

class _SavedRecipePageState extends State<SavedRecipePage> {
  late SavedRecipeController savedRecipeController;

  @override
  void initState() {
    savedRecipeController = Get.find<SavedRecipeController>();
    savedRecipeController.getSavedRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Saved Recipes"),
      body: GetBuilder<SavedRecipeController>(
        builder: (controller) {
          return controller.isLoading
              ? Center(child: CircularProgressIndicator())
              : controller.savedRecipes.isEmpty
              ? Center(child: Text("No Saved Items Yet"))
              : ListView.builder(
                padding: EdgeInsets.only(bottom: 100),
                itemCount: controller.savedRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = controller.savedRecipes[index];
                  return InkWell(
                    onTap: () {
                      Get.to(
                        () => DetailPage(
                          recipe: recipe,
                          id: recipe.id,
                          xFromSearchPage: false,
                        ),
                        transition: Transition.leftToRight,
                        duration: Duration(milliseconds: 300),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 18, right: 18, top: 10),
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.all(0),
                            // enableFeedback: true,
                            leading: SizedBox(
                              width: 80,
                              child: CachedImage(imageUrl: recipe.image),
                            ),
                            title: Text(
                              recipe.title * 3,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            subtitle: Row(
                              spacing: 10,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.accentColor,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Row(
                                    spacing: 3,
                                    children: [
                                      Icon(TablerIcons.clock, size: 16),
                                      Text(
                                        '${recipe.readyInMinutes}min',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            trailing: PopupMenuButton<String>(
                              color: Colors.white,
                              iconSize: 18,
                              icon: const Icon(TablerIcons.dots_vertical),
                              onSelected:
                                  (value) => {
                                    savedRecipeController.removeRecipeById(
                                      recipe.id,
                                    ),
                                  },
                              itemBuilder:
                                  (context) => [
                                    const PopupMenuItem(
                                      value: 'Delete',
                                      child: Text(
                                        'Remove',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                            ),
                          ),
                          5.heightBox(),
                          Visibility(
                            visible:
                                (index != controller.savedRecipes.length - 1),
                            child: Divider(
                              color: AppColors.textSecond,
                              thickness: 0.5,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
        },
      ),
    );
  }
}
