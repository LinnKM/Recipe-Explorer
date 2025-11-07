import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:recipe_explorer/app_extension.dart';
import 'package:shimmer/shimmer.dart';

class HomePageBannerShimmer extends StatelessWidget {
  const HomePageBannerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withAlpha(0.4.toAlpha()),
        ),
        height: 200,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, bottom: 8),
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(10),
                color: Colors.black.withAlpha(0.5.toAlpha()),
              ),
              width: Get.width * 0.5,
              height: 15,
            ),

            Container(
              margin: EdgeInsets.only(left: 20, bottom: 30),
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(10),
                color: Colors.black.withAlpha(0.5.toAlpha()),
              ),
              width: Get.width * 0.3,
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
