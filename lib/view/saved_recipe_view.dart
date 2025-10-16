import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:recipe_explorer/Colors/app_colors.dart';
import 'package:recipe_explorer/controller/saved_recipe_controller.dart';
import 'package:recipe_explorer/view/recipe_detail_view.dart';
import 'package:recipe_explorer/widgets/cached_image.dart';
import 'package:recipe_explorer/widgets/custom_sliver_appbar.dart';

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<SavedRecipeController>(
          builder: (controller) {
            return CustomScrollView(
              slivers: [
                CustomSliverAppbar(
                  title: Text(
                    'Saved Recipes',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                ),

                SliverToBoxAdapter(child: SizedBox(height: 8)),

                controller.isLoading
                    ? SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    )
                    : controller.savedRecipes.isEmpty
                    ? SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.35),
                        child: Center(child: Text('NO SAVED ITEMS YET')),
                      ),
                    )
                    : SliverList.builder(
                      addAutomaticKeepAlives: true,
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
                            padding: EdgeInsets.only(
                              left: 18,
                              right: 18,
                              top: 10,
                            ),
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
                                          borderRadius: BorderRadius.circular(
                                            18,
                                          ),
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
                                          savedRecipeController
                                              .removeRecipeById(recipe.id),
                                        },
                                    itemBuilder:
                                        (context) => [
                                          const PopupMenuItem(
                                            value: 'Delete',
                                            child: Text(
                                              'Remove',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Divider(
                                  color: AppColors.textSecond,
                                  thickness: 0.5,
                                  height: 0,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            );
          },
        ),
      ),
    );
  }
}
