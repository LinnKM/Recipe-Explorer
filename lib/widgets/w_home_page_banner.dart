import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:recipe_explorer/Colors/app_colors.dart';
import 'package:recipe_explorer/app_extension.dart';
import 'package:recipe_explorer/model/recipe_model.dart';
import 'package:recipe_explorer/view/recipe_detail_view.dart';
import 'package:recipe_explorer/widgets/w_bookmark_button.dart';
import 'package:recipe_explorer/widgets/w_cached_image.dart';

class HomePageBannerWidget extends StatelessWidget {
  final List<RecipeModel> recipes;

  const HomePageBannerWidget({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    RxInt selectedIndex = 0.obs;

    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: 3,
            onPageChanged: (value) {
              selectedIndex.value = value;
            },
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return GestureDetector(
                onTap: () {
                  Get.to(
                    () => DetailPage(
                      id: recipe.id,
                      recipe: recipe,
                      xFromSearchPage: false,
                    ),
                  );
                },
                child: Stack(
                  children: [
                    CachedImage(imageUrl: recipe.image),

                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withAlpha(8),
                            Colors.black.withAlpha(100),
                            Colors.black.withAlpha(140),
                          ],
                        ),
                      ),
                    ),

                    // Title Part
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            recipe.title,
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),

                          SizedBox(height: 3),

                          Row(
                            spacing: 10,
                            children: [
                              Row(
                                spacing: 3,
                                children: [
                                  Icon(
                                    TablerIcons.clock,
                                    color: AppColors.accentColor,
                                    size: 20,
                                  ),
                                  Text(
                                    '${recipe.readyInMinutes} min',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                spacing: 3,
                                children: [
                                  Icon(
                                    TablerIcons.users,
                                    color: AppColors.accentColor,
                                    size: 20,
                                  ),
                                  Text(
                                    '${recipe.servings} servings',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
                              color: Colors.black.withAlpha(0.15.toAlpha()),
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
              );
            },
          ),

          // Indicator Part
          Obx(
            () => Positioned(
              left: 100,
              bottom: 10,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Row(
                      spacing: 6,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          decoration: BoxDecoration(
                            borderRadius:
                                (selectedIndex.value == index)
                                    ? BorderRadius.circular(18)
                                    : BorderRadius.circular(20),
                            color:
                                (selectedIndex.value == index)
                                    ? AppColors.accentColor
                                    : Colors.white.withAlpha(100),
                          ),
                          height: 6,
                          width: (selectedIndex.value == index) ? 18 : 6,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
