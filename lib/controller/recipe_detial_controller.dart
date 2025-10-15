import 'package:get/get.dart';
import 'package:recipe_explorer/model/recipe_model.dart';
import 'package:recipe_explorer/service/network%20services/api_service.dart';

class RecipeDetialController extends GetxController {
  RecipeModel? recipe;
  bool isLoading = false;

  Future<void> getRecipeDetial(int id) async {
    isLoading = true;
    update();

    final data = await ApiService().getRecipeDetial(id: id);

    if (data != null) {
      updateRecipe(data);
    } else {}

    isLoading = false;
    update();
  }

  void updateRecipe(RecipeModel recipe) {
    this.recipe = recipe;
  }

  @override
  void onInit() {
    super.onInit();
  }
}
