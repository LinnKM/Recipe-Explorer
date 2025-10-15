import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_explorer/view/home_view.dart';

class StartUpPage extends StatefulWidget {
  const StartUpPage({super.key});

  @override
  State<StartUpPage> createState() => _StartUpPageState();
}

class _StartUpPageState extends State<StartUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/image/startup_banner (2).jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            // width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.25),
                    Colors.black.withOpacity(0.1),
                  ],
                  begin: Alignment.bottomCenter,
                  // end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Food',
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Recipes',
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Easy to make Food',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xffF9F9F9),
                    fontSize: 24,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.25,
              ),
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  fixedSize: Size(0, 50),
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  backgroundColor: Color(0xffD99651),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () {
                  // Get.to(HomePage());
                  Get.to(() => HomePage());
                },
                child: Text(
                  'Get Started',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
