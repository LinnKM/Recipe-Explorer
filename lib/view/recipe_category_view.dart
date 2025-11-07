import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:recipe_explorer/Colors/app_colors.dart';
import 'package:recipe_explorer/app_extension.dart';
import 'package:recipe_explorer/controller/recipe_category_controller.dart';
import 'package:recipe_explorer/view/recipe_detail_view.dart';
import 'package:recipe_explorer/widgets/w_bookmark_button.dart';
import 'package:recipe_explorer/widgets/w_cached_image.dart';
import 'package:recipe_explorer/widgets/w_custom_appbar.dart';
import 'package:recipe_explorer/widgets/w_gradient_box.dart';

class RecipeCategoryPage extends StatefulWidget {
  final String title;

  const RecipeCategoryPage({super.key, required this.title});
  @override
  State<RecipeCategoryPage> createState() => _RecipeCategoryPageState();
}

class _RecipeCategoryPageState extends State<RecipeCategoryPage> {
  late RecipeCategoryController recipeCategoryController;

  @override
  void initState() {
    recipeCategoryController = Get.put(RecipeCategoryController());
    recipeCategoryController.getRecipesByTag(widget.title.toLowerCase());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: SafeArea(
        child: GetBuilder<RecipeCategoryController>(
          builder: (controller) {
            return controller.isLoading
                ? Center(
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
                : controller.recipesByTag.isEmpty
                ? Center(child: Text("Something Went Wrong"))
                : Expanded(
                  child: ListView.builder(
                    itemCount: controller.recipesByTag.length,
                    itemBuilder: (context, index) {
                      final recipe = controller.recipesByTag[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          height: Get.height * 0.18,
                          child: GestureDetector(
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
                            child: Stack(
                              children: [
                                CachedImage(imageUrl: recipe.image),

                                GradientBox(),

                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: SizedBox(
                                    width: Get.width * 0.5,
                                    child: Text(
                                      recipe.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),

                                Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: Row(
                                    spacing: 3,
                                    children: [
                                      Icon(
                                        TablerIcons.clock,
                                        color: AppColors.accentColor,
                                        size: 20,
                                      ),
                                      Text(
                                        '${recipe.readyInMinutes}min',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Positioned(
                                  right: 10,
                                  top: 10,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withAlpha(
                                            0.15.toAlpha(),
                                          ),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                        ),
                                      ],
                                      color: AppColors.primaryColor.withAlpha(
                                        0.4.toAlpha(),
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: BookmarkButton(recipe: recipe),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
          },
        ),
      ),
    );
  }
}
