import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipe_explorer/controller/recipe_detial_controller.dart';
import 'package:recipe_explorer/model/recipe_model.dart';

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
    final isInstructionHtml = isHtml(widget.recipe.instructions);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Recipe Detail'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<RecipeDetialController>(
            builder: (controller) {
              return controller.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : (controller.recipe != null)
                  ? Column(
                    children: [
                      // Recipe Detail Banner
                      _buildRecipeDetailBanner(controller.recipe!),

                      // Overview Section
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            isInstructionHtml
                                ? Html(
                                  data: """ ${widget.recipe.instructions} """,
                                )
                                : Text(
                                  controller.recipe!.instructions,
                                  textAlign: TextAlign.justify,
                                  // overflow: TextOverflow.ellipsis,
                                ),
                          ],
                        ),
                      ),
                    ],
                  )
                  : Center(child: Text('Something Went Wrong'));
            },
          ),
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

Widget _buildRecipeDetailBanner(RecipeModel recipe) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.amber,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(recipe.image),
                ),
              ),
            ),

            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withAlpha(50),
                    Colors.white.withAlpha(100),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text('${recipe.servings} Serves'),
              ),
            ),

            Positioned(
              bottom: 8,
              right: 8,
              child: Row(
                children: [
                  Icon(Icons.timer_sharp),
                  Text('${recipe.readyInMinutes} min'),
                  Icon(Iconsax.save_add, color: Colors.green),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 10),

        Text(
          recipe.title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
