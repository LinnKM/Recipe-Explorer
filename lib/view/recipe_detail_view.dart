import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:readmore/readmore.dart';
import 'package:recipe_explorer/Colors/app_colors.dart';
import 'package:recipe_explorer/app_extension.dart';
import 'package:recipe_explorer/controller/recipe_detial_controller.dart';
import 'package:recipe_explorer/model/recipe_model.dart';
import 'package:recipe_explorer/widgets/w_bookmark_button.dart';
import 'package:recipe_explorer/widgets/w_cached_image.dart';
import 'package:recipe_explorer/widgets/w_custom_appbar.dart';

class DetailPage extends StatefulWidget {
  final bool xFromSearchPage;
  final RecipeModel recipe;
  final int id;

  const DetailPage({
    super.key,
    required this.recipe,
    required this.id,
    required this.xFromSearchPage,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late RecipeDetialController recipeDetialController;

  @override
  void initState() {
    recipeDetialController = Get.put(RecipeDetialController());

    if (widget.xFromSearchPage) {
      recipeDetialController.getRecipeDetial(widget.id);
    } else {
      recipeDetialController.updateRecipe(widget.recipe);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Recipe Detail",
        automaticallyImplyLeading: true,
        actionsPadding: EdgeInsets.only(right: 20),
        actions: [BookmarkButton(recipe: widget.recipe)],
      ),
      body: SafeArea(
        child: GetBuilder<RecipeDetialController>(
          builder: (controller) {
            return controller.isLoading
                ? Center(
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
                : controller.recipe == null
                ? Center(child: Text('Something Went Wrong'))
                : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 180,
                          child: CachedImage(
                            imageUrl: controller.recipe!.image,
                            borderRadius: 18,
                          ),
                        ),

                        SizedBox(height: 10),

                        Text(
                          controller.recipe!.title,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        SizedBox(height: 15),

                        Row(
                          spacing: 8,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.accentColor.withAlpha(
                                  0.8.toAlpha(),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                spacing: 3,
                                children: [
                                  Icon(TablerIcons.users, size: 16),
                                  Text(
                                    '${controller.recipe!.servings} servings',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.accentColor.withAlpha(
                                  0.8.toAlpha(),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                spacing: 3,
                                children: [
                                  Icon(TablerIcons.clock, size: 16),
                                  Text(
                                    '${controller.recipe!.readyInMinutes} min',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        Divider(
                          color: AppColors.textSecond,
                          thickness: 0.5,
                          height: 40,
                        ),

                        // Summary Part
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About This Recipe',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: ReadMoreText(
                                style: TextStyle(fontSize: 15),
                                controller.recipe!.summary.isEmpty
                                    ? '- No Summary Available'
                                    : (isHtml(controller.recipe!.summary))
                                    ? htmlToPlainText(
                                      controller.recipe!.summary,
                                    )
                                    : controller.recipe!.summary,
                                trimLines: 5,
                                colorClickableText: Colors.blue,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: ' See more...',
                                trimExpandedText: ' See less',
                                moreStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                lessStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Instructions',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: ReadMoreText(
                                style: TextStyle(fontSize: 15),
                                controller.recipe!.instructions.isEmpty
                                    ? '- No Summary Available'
                                    : (isHtml(controller.recipe!.instructions))
                                    ? htmlToPlainText(
                                      controller.recipe!.instructions,
                                    )
                                    : controller.recipe!.instructions,
                                trimLines: 5,
                                colorClickableText: Colors.blue,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: ' See more...',
                                trimExpandedText: ' See less',
                                moreStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                lessStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
          },
        ),
      ),
    );
  }
}

bool isHtml(String text) {
  final htmlPattern = RegExp(
    r'<[^>]+>',
  ); // Detects tags like <b>, <i>, <p>, etc.
  return htmlPattern.hasMatch(text);
}

String htmlToPlainText(String htmlString) {
  final document = html_parser.parse(htmlString);
  return document.body?.text ?? '';
}
