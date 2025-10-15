import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:recipe_explorer/Colors/app_colors.dart';
import 'package:recipe_explorer/controller/home_main_controller.dart';
import 'package:recipe_explorer/view/recipe_detail_view.dart';
import 'package:recipe_explorer/view/search_recipe_view.dart';
import 'package:recipe_explorer/widgets/cached_image.dart';

class HomeMainPage extends StatefulWidget {
  const HomeMainPage({super.key});

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  int selectedIndex = 0;

  @override
  void initState() {
    Get.put(HomeMainPageController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          toolbarHeight: Get.height * 0.09,
          pinned: true,
          backgroundColor: Colors.white,
          title: Text(
            'Recipe Explorer',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(
                  () => SearchRecipePage(),
                  transition: Transition.leftToRight,
                  duration: Duration(milliseconds: 200),
                );
              },
              icon: Icon(TablerIcons.search, color: AppColors.textSecond),
            ),
          ],
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
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                // Discover Part
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Discover',
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      SizedBox(
                        height: 200,
                        child: GetBuilder<HomeMainPageController>(
                          builder: (controller) {
                            return controller.isLoading
                                ? Center(child: CircularProgressIndicator())
                                : controller.recipes.isEmpty
                                ? Center(child: Text('something went wrong'))
                                : Stack(
                                  children: [
                                    // Main Page View
                                    PageView.builder(
                                      controller: PageController(),
                                      itemCount: 3,
                                      onPageChanged: (value) {
                                        selectedIndex = value;
                                        setState(() {});
                                      },
                                      itemBuilder: (context, index) {
                                        final recipe =
                                            controller.recipes[index];
                                        // Image Part
                                        return GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              () => DetailPage(
                                                id: recipe.id,
                                                recipe: recipe,
                                                xFromSearchPage: false,
                                              ),
                                              transition:
                                                  Transition.leftToRight,
                                              duration: Duration(
                                                milliseconds: 200,
                                              ),
                                            );
                                          },
                                          child: Stack(
                                            children: [
                                              CachedImage(
                                                imageUrl: recipe.image,
                                              ),

                                              Container(
                                                height: 300,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.black.withAlpha(8),
                                                      Colors.black.withAlpha(
                                                        100,
                                                      ),
                                                      Colors.black.withAlpha(
                                                        140,
                                                      ),
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      recipe.title,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                              color:
                                                                  AppColors
                                                                      .accentColor,
                                                              size: 20,
                                                            ),
                                                            Text(
                                                              '${recipe.readyInMinutes}min',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        Row(
                                                          spacing: 3,
                                                          children: [
                                                            Icon(
                                                              TablerIcons
                                                                  .chef_hat,
                                                              color:
                                                                  AppColors
                                                                      .accentColor,
                                                              size: 20,
                                                            ),
                                                            Text(
                                                              'Easy',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors
                                                                        .white,
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
                                            ],
                                          ),
                                        );
                                      },
                                    ),

                                    // Indicator Part
                                    Positioned(
                                      left: 100,
                                      bottom: 10,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Center(
                                          child: SizedBox(
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width /
                                                4,
                                            child: Row(
                                              spacing: 6,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: List.generate(
                                                3,
                                                (index) => AnimatedContainer(
                                                  duration: Duration(
                                                    milliseconds: 400,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        (selectedIndex == index)
                                                            ? BorderRadius.circular(
                                                              18,
                                                            )
                                                            : BorderRadius.circular(
                                                              20,
                                                            ),
                                                    color:
                                                        (selectedIndex == index)
                                                            ? AppColors
                                                                .accentColor
                                                            : Colors.white
                                                                .withAlpha(100),
                                                  ),
                                                  height: 6,
                                                  width:
                                                      (selectedIndex == index)
                                                          ? 18
                                                          : 6,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Category Part
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    SizedBox(height: 8),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 120,
                      child: ListView.builder(
                        padding: EdgeInsets.only(left: 20),
                        itemCount: RecipeCategory.values.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 20),
                            width: 199,
                            child: Stack(
                              children: [
                                Container(
                                  height: 120,
                                  width: 199,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                        RecipeCategory
                                            .values[index]
                                            .imageAssest,
                                      ),
                                    ),
                                  ),
                                ),

                                Container(
                                  height: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withAlpha(50),
                                        Colors.black.withAlpha(120),
                                      ],
                                    ),
                                  ),
                                ),

                                Positioned(
                                  left: 10,
                                  bottom: 10,
                                  child: Text(
                                    RecipeCategory.values[index].name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
