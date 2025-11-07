import 'package:get/get.dart';
import 'package:recipe_explorer/model/recipe_model.dart';
import 'package:recipe_explorer/service/network%20services/api_service.dart';

enum RecipeCategory {
  pizza(name: 'Pizza', imageAssest: 'asset/image/pizza.jpeg'),
  pasta(name: 'Pasta', imageAssest: 'asset/image/pasta.jpg'),
  steak(name: 'Steak', imageAssest: 'asset/image/steak.jpg'),
  chicken(name: 'Chicken', imageAssest: 'asset/image/chicken.jpg'),
  noolde(name: 'Noodle', imageAssest: 'asset/image/noodle.jpg');

  final String name;
  final String imageAssest;

  const RecipeCategory({required this.name, required this.imageAssest});
}

class HomeMainPageController extends GetxController {
  bool isLoading = true;
  String selectedTag = 'For You';

  List<RecipeModel> recipes = [];

  void updateSelectedTag(String tag) {
    selectedTag = tag;
    update();
  }

  Future<void> getRandomRecipes(int count) async {
    final data = await ApiService().getRandomRecipes();

    if (data != null) {
      recipes = data;
    } else {}

    isLoading = false;
    update();
  }

  @override
  void onInit() {
    // getRandomRecipes(10);
    super.onInit();
  }
}
