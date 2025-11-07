import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:recipe_explorer/Colors/app_colors.dart';
import 'package:recipe_explorer/app_extension.dart';
import 'package:recipe_explorer/controller/home_main_controller.dart';
import 'package:recipe_explorer/view/recipe_category_view.dart';
import 'package:recipe_explorer/view/search_recipe_view.dart';
import 'package:recipe_explorer/widgets/w_custom_appbar.dart';
import 'package:recipe_explorer/widgets/w_home_page_banner.dart';
import 'package:recipe_explorer/widgets/w_home_page_banner_shimmer.dart';

class HomeMainPage extends StatefulWidget {
  const HomeMainPage({super.key});

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  int selectedIndex = 0;
  late HomeMainPageController homeMainPageController;

  @override
  void initState() {
    homeMainPageController = Get.put(HomeMainPageController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "CookOo",
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
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 16),
        child: RefreshIndicator(
          backgroundColor: Colors.white,
          color: AppColors.primaryColor,
          onRefresh: () async {
            await homeMainPageController.getRandomRecipes(10);
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
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
                        "Discover",
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      GetBuilder<HomeMainPageController>(
                        builder: (controller) {
                          return controller.isLoading
                              ? HomePageBannerShimmer()
                              : controller.recipes.isEmpty
                              ? Center(
                                child: Text('Check your Ineternet Connection!'),
                              )
                              : HomePageBannerWidget(
                                recipes: controller.recipes,
                              );
                        },
                      ),
                    ],
                  ),
                ),
                20.heightBox(),

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
                    8.heightBox(),

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
                          final title = RecipeCategory.values[index].name;
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                () => RecipeCategoryPage(title: title),
                                transition: Transition.leftToRight,
                                duration: Duration(milliseconds: 300),
                              );
                            },
                            child: Container(
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
      ),
    );
  }
}
