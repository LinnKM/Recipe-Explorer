import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:recipe_explorer/Colors/app_colors.dart';
import 'package:recipe_explorer/view/home_main_view.dart';
import 'package:recipe_explorer/view/saved_recipe_view.dart';
import 'package:recipe_explorer/widgets/keep_alive_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController();

  List iconLst = [
    [Icons.home, Icons.home_outlined],
    [TablerIcons.bookmark_filled, TablerIcons.bookmark],
  ];
  RxInt selectedIcon = 0.obs;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Expanded(
              child: PageView(
                onPageChanged: (value) {
                  selectedIcon.value = value;
                },
                controller: pageController,
                children: [
                  HomeMainPage(),
                  KeepAlivePage(child: SavedRecipePage()),
                ],
              ),
            ),

            // Bottom Navigation
            Obx(
              () => Positioned(
                bottom: 20,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(
                              60,
                            ), // 50% opacity black
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffffffff),
                      ),
                      width: MediaQuery.of(context).size.width / 2,
                      height: 48,

                      child: Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(iconLst.length * 2 - 1, (
                          index,
                        ) {
                          if (index.isOdd) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: VerticalDivider(),
                            );
                          }

                          final iconIndex = index ~/ 2;
                          return AnimatedScale(
                            duration: Duration(milliseconds: 200),
                            scale: (selectedIcon == iconIndex) ? 1.3 : 1,
                            child: InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                selectedIcon.value = iconIndex;
                                pageController.animateToPage(
                                  iconIndex,
                                  duration: Duration(microseconds: 300),
                                  curve: Curves.ease,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 10),
                                  child: Icon(
                                    (selectedIcon == iconIndex)
                                        ? iconLst[iconIndex][0]
                                        : iconLst[iconIndex][1],
                                    size: 24,
                                    color:
                                        (selectedIcon == iconIndex)
                                            ? Colors.black
                                            : AppColors.textSecond,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        // SingleChildScrollView(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       SizedBox(height: 20),

        //       Padding(
        //         padding: EdgeInsets.symmetric(horizontal: 20),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               "Good Morning",
        //               style: TextStyle(
        //                 fontSize: 24,
        //                 fontWeight: FontWeight.bold,
        //                 color: Colors.black,
        //               ),
        //             ),

        //             SizedBox(height: 5),

        //             Text(
        //               "What are you cooking today?",
        //               style: TextStyle(
        //                 fontSize: 14,
        //                 fontWeight: FontWeight.normal,
        //                 color: Color(0xffA9A9A9),
        //               ),
        //             ),

        //             SizedBox(height: 30),

        //             IconButton(
        //               onPressed: () {
        //                 Get.to(() => SearchRecipePage());
        //               },
        //               icon: Icon(TablerIcons.search),
        //             ),

        //             SizedBox(height: 15),
        //           ],
        //         ),
        //       ),

        //       SizedBox(height: 10),

        //       GetBuilder<HomePageController>(
        //         builder: (controller) {
        //           return Column(
        //             children: [
        //               SizedBox(
        //                 height: 35,
        //                 child: ListView.builder(
        //                   padding: EdgeInsets.only(left: 20),
        //                   itemCount: controller.tagList.length,
        //                   scrollDirection: Axis.horizontal,
        //                   itemBuilder: (context, index) {
        //                     final tag = controller.tagList[index];
        //                     final isSelected =
        //                         controller.tagList[index] ==
        //                         controller.selectedTag;

        //                     return GestureDetector(
        //                       onTap: () {
        //                         controller.updateSelectedTag(tag);
        //                         controller.getRecipesByTag(
        //                           (tag.toLowerCase() == 'for you')
        //                               ? ''
        //                               : tag.toLowerCase(),
        //                         );
        //                       },
        //                       child: Container(
        //                         alignment: Alignment.center,
        //                         margin: EdgeInsets.only(right: 20),
        //                         decoration: BoxDecoration(
        //                           color:
        //                               (isSelected)
        //                                   ? Color(0xff129575)
        //                                   : Colors.transparent,
        //                           borderRadius: BorderRadius.circular(10),
        //                         ),
        //                         padding: EdgeInsets.symmetric(
        //                           horizontal: 10,
        //                           vertical: 7,
        //                         ),
        //                         child: Text(
        //                           controller.tagList[index],
        //                           style: TextStyle(
        //                             fontSize: 14,
        //                             color:
        //                                 (isSelected)
        //                                     ? Colors.white
        //                                     : Color(0xff129575),
        //                             fontWeight: FontWeight.w500,
        //                           ),
        //                         ),
        //                       ),
        //                     );
        //                   },
        //                 ),
        //               ),

        //               SizedBox(height: 30),

        //               (controller.recipes.isEmpty)
        //                   ? Container(
        //                     alignment: Alignment.center,
        //                     height: 230,
        //                     child: Text('Try Again Later'),
        //                   )
        //                   : SizedBox(
        //                     height: 230,
        //                     child: ListView.builder(
        //                       padding: EdgeInsets.only(left: 20),
        //                       scrollDirection: Axis.horizontal,
        //                       itemCount: controller.recipes.length,
        //                       itemBuilder: (context, index) {
        //                         final recipe = controller.recipes[index];

        //                         return GestureDetector(
        //                           onTap: () {
        //                             Get.to(
        //                               () => DetailPage(
        //                                 recipe: recipe,
        //                                 id: recipe.id,
        //                                 xFromSearchPage: false,
        //                               ),
        //                             );
        //                           },
        //                           child: Container(
        //                             width: 150,
        //                             margin: EdgeInsets.only(right: 20),
        //                             padding: EdgeInsets.all(10),
        //                             decoration: BoxDecoration(
        //                               color: Color(0xffD9D9D9),
        //                               borderRadius: BorderRadius.circular(15),
        //                             ),
        //                             child: Column(
        //                               crossAxisAlignment:
        //                                   CrossAxisAlignment.center,
        //                               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                               children: [
        //                                 Container(
        //                                   width: 109,
        //                                   height: 110,
        //                                   decoration: BoxDecoration(
        //                                     shape: BoxShape.circle,
        //                                     color: Colors.blue,
        //                                     image: DecorationImage(
        //                                       fit: BoxFit.cover,
        //                                       image: NetworkImage(
        //                                         controller.recipes[index].image,
        //                                       ),
        //                                     ),
        //                                   ),
        //                                 ),
        //                                 SizedBox(height: 15),
        //                                 Text(
        //                                   controller.recipes[index].title,
        //                                   maxLines: 2,
        //                                   textAlign: TextAlign.center,
        //                                   style: TextStyle(),
        //                                 ),
        //                                 Spacer(),
        //                                 Row(
        //                                   mainAxisAlignment:
        //                                       MainAxisAlignment.spaceBetween,
        //                                   children: [
        //                                     Text(
        //                                       '${controller.recipes[index].readyInMinutes} Mins',
        //                                     ),

        //                                     Icon(Icons.save),
        //                                   ],
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         );
        //                       },
        //                     ),
        //                   ),
        //             ],
        //           );
        //         },
        //       ),
        //       SizedBox(height: 20),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
