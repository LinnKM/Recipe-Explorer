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
      backgroundColor: Colors.blueAccent,
      body: RefreshIndicator(
        child: Expanded(
          child: ListView(
            children: [
              Container(
                height: Get.height,
                child: Center(child: Text('hello')),
              ),
            ],
          ),
        ),
        onRefresh: () async {
          await Future.delayed(Durations.medium4);
        },
      ),
    );
  }
}
