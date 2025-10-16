import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:recipe_explorer/Colors/app_colors.dart';
import 'package:recipe_explorer/controller/recipe_category_controller.dart';
import 'package:recipe_explorer/view/recipe_detail_view.dart';
import 'package:recipe_explorer/widgets/bookmark_button.dart';
import 'package:recipe_explorer/widgets/cached_image.dart';
import 'package:recipe_explorer/widgets/custom_sliver_appbar.dart';
import 'package:recipe_explorer/widgets/gradient_box.dart';

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<RecipeCategoryController>(
          builder: (controller) {
            return CustomScrollView(
              slivers: [
                CustomSliverAppbar(
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(TablerIcons.arrow_narrow_left, size: 25),
                  ),
                  title: Text(
                    widget.title,
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 10)),

                controller.isLoading
                    ? SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Center(
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      ),
                    )
                    : controller.recipesByTag.isEmpty
                    ? SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: Get.width * 0.35),
                        child: Center(child: Text('Something Went Wrong')),
                      ),
                    )
                    : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        addAutomaticKeepAlives: true,
                        childCount: controller.recipesByTag.length,
                        (context, index) {
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
                                              color: Colors.black.withOpacity(
                                                0.3,
                                              ),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                            ),
                                          ],
                                          color: AppColors.primaryColor
                                              .withOpacity(0.4),
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
                    ),

                SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            );
          },
        ),
      ),
    );
  }
}
