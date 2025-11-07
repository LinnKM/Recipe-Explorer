import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_explorer/app_enum.dart';
import 'package:recipe_explorer/app_extension.dart';
import 'package:recipe_explorer/view/home_main_view.dart';
import 'package:recipe_explorer/view/saved_recipe_view.dart';
import 'package:recipe_explorer/widgets/w_navigation_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController();
  RxInt selectedIndex = 0.obs;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            allowImplicitScrolling: true,
            onPageChanged: (value) {
              selectedIndex.value = value;
            },
            controller: pageController,
            children: [HomeMainPage(), SavedRecipePage()],
          ),

          // Bottom Navigation
          Obx(
            () => Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.sizeOf(context).width / 2.5,
                margin: EdgeInsets.symmetric(vertical: 16),
                // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(0.095.toAlpha()),
                      blurRadius: 8,
                      spreadRadius: 0.5,
                      offset: Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffffffff),
                ),

                child: Row(
                  children: [
                    Expanded(
                      child: NavigationItemWidget(
                        onTap: () {
                          pageController.animateToPage(
                            0,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.linear,
                          );
                        },
                        selectedIndex: selectedIndex.value,
                        navigationitem: Navigation.home,
                      ),
                    ),

                    SizedBox(height: 24, child: VerticalDivider()),

                    Expanded(
                      child: NavigationItemWidget(
                        onTap: () {
                          pageController.animateToPage(
                            1,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.linear,
                          );
                        },
                        selectedIndex: selectedIndex.value,
                        navigationitem: Navigation.saved,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
