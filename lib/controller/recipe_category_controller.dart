import 'package:get/get.dart';
import 'package:recipe_explorer/model/recipe_model.dart';
import 'package:recipe_explorer/service/network%20services/api_service.dart';

class RecipeCategoryController extends GetxController {
  bool isLoading = true;
  List<RecipeModel> recipesByTag = [];

  Future<void> getRecipesByTag(String tag) async {
    isLoading = true;
    update();

    final data = await ApiService().getRecipesByTag(tag: tag);

    if (data != null) {
      recipesByTag = data;
    } else {}

    isLoading = false;
    update();
  }
}
