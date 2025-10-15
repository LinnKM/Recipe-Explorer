import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:recipe_explorer/controller/search_recipe_controller.dart';
import 'package:recipe_explorer/view/recipe_detail_view.dart';

class SearchRecipePage extends StatefulWidget {
  const SearchRecipePage({super.key});

  @override
  State<SearchRecipePage> createState() => _SearchRecipePageState();
}

class _SearchRecipePageState extends State<SearchRecipePage> {
  late SearchRecipeController searchController;

  @override
  void initState() {
    searchController = Get.put(SearchRecipeController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(),
        title: Text('Search Recipes'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: GetBuilder<SearchRecipeController>(
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  TextField(
                    controller: controller.textController,
                    cursorColor: Color(0xffD99651),
                    style: TextStyle(color: Color(0xff535353)),
                    onChanged: (value) {
                      controller.searchRecipesByIngredients(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search recipe by Ingredients',
                      isDense: true,
                      hintStyle: TextStyle(
                        color: Color(0xffD9D9D9),
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 24,
                        color: Color(0xffD9D9D9),
                      ),

                      suffixIcon:
                          controller.hasText
                              ? GestureDetector(
                                onTap: () {
                                  controller.clearTextController();
                                },
                                child: Icon(TablerIcons.x, color: Colors.grey),
                              )
                              : SizedBox.shrink(),

                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffD9D9D9)),
                        borderRadius: BorderRadius.circular(16),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffD9D9D9)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Search Result',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),

                  controller.xLoading
                      ? Center(
                        child: SizedBox(
                          height: 2,
                          width: 25,
                          child: CircularProgressIndicator(strokeWidth: 2.5),
                        ),
                      )
                      : (controller.searchRecipes.isEmpty)
                      ? Expanded(
                        child: Center(
                          child: Text(
                            (controller.textController.text.isEmpty)
                                ? ''
                                : 'No Recipe Found',
                          ),
                        ),
                      )
                      : Expanded(
                        child: GridView.builder(
                          itemCount: controller.searchRecipes.length,
                          padding: EdgeInsets.only(top: 5, bottom: 30),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 140,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                crossAxisCount: 2,
                              ),
                          itemBuilder: (context, index) {
                            final recipe = controller.searchRecipes[index];
                            return GestureDetector(
                              onTap: () {
                                print('RecipeId : ${recipe.id}');
                                Get.to(
                                  DetailPage(
                                    recipe: recipe,
                                    id: recipe.id,
                                    xFromSearchPage: true,
                                  ),
                                );
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    // height: 120,
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
                                    height: 300,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withAlpha(50),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 8,
                                    top: 8,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        spacing: 3,
                                        children: [
                                          Icon(TablerIcons.thumb_up, size: 18),
                                          Text('${recipe.likes}'),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child: SizedBox(
                                      width: 140 * 0.7,
                                      child: Text(
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                        recipe.title,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// Widget _buildCustomTextFiled(
//   BuildContext context,
//   TextEditingController textController,
// ) {
//   return TextField(
//     controller: textController,
//     cursorColor: Color(0xffD99651),
//     style: TextStyle(color: Color(0xff535353)),
//     onChanged: (value) {},
//     decoration: InputDecoration(
//       hintText: 'Search recipe',
//       isDense: true,
//       hintStyle: TextStyle(color: Color(0xffD9D9D9), fontSize: 14),
//       prefixIcon: Icon(Icons.search, size: 24, color: Color(0xffD9D9D9)),

//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Color(0xffD9D9D9)),
//         borderRadius: BorderRadius.circular(16),
//       ),

//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Color(0xffD9D9D9)),
//         borderRadius: BorderRadius.circular(16),
//       ),
//     ),
//   );
// }
