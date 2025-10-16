import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List strLst = ['Summary', 'Instructions'];

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.withAlpha(50),
          ),
          margin: EdgeInsets.symmetric(horizontal: Get.width * 0.235),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 10,
            children: List.generate(
              strLst.length,
              (index) => GestureDetector(
                onTap: () {
                  selectedTab = index;
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color:
                        (selectedTab == index)
                            ? Colors.blue
                            : Colors.transparent,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(strLst[index]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
