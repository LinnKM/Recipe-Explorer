import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:recipe_explorer/model/recipe_model.dart';
import 'package:recipe_explorer/service/network%20services/api_service.dart';

class SearchRecipeController extends GetxController {
  final TextEditingController textController = TextEditingController();

  List<RecipeModel> searchRecipes = [];
  Timer? debounce;
  bool xLoading = false;
  bool hasText = false;

  @override
  void onInit() {
    textController.addListener(() {
      if (textController.text.isEmpty) {
        hasText = false;
        searchRecipes.clear();
        update();
      } else {
        hasText = true;
      }
    });
    super.onInit();
  }

  Future<void> searchRecipesByIngredients(String searchWord) async {
    xLoading = true;
    update();

    if (debounce != null) {
      debounce!.cancel();
    }

    if (searchWord.isEmpty) {
      searchRecipes.clear();
      xLoading = false;
      update();
    } else {
      debounce = Timer(Duration(milliseconds: 600), () async {
        final data = await ApiService().searchRecipesByIngredients(
          searchWord: searchWord,
        );

        if (data != null) {
          searchRecipes = data;
          print(searchRecipes.length);
        }

        xLoading = false;
        update();
      });
    }
  }

  void clearTextController() {
    textController.clear();
  }

  @override
  void onClose() {
    if (debounce != null) {
      debounce!.cancel();
    }
    clearTextController();
    super.onClose();
  }
}
