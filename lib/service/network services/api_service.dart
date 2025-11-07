import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:recipe_explorer/model/recipe_model.dart';
import 'package:recipe_explorer/service/network%20services/api_end_points.dart';

class ApiService {
  static final String baseUrl = 'https://api.spoonacular.com/recipes/';
  static final String apiKey = 'c0a3d713f6ff4462ba9f19a46544c47b';

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {"accept": "*/*", "Content-Type": "application/json"},
      queryParameters: {"apiKey": apiKey},
    ),
  );

  Future<Iterable?> get({required String endPoint}) async {
    Iterable data = {};
    try {
      final response = await dio.get(endPoint);
      if (response.statusCode! <= 299 && response.statusCode! >= 200) {
        data = response.data['recipes'] as Iterable;
      }
      return data;
    } on DioException catch (e) {
      Get.snackbar('Error Messgage', '${e.message}');
      return null;
    }
  }

  Future<List<RecipeModel>?> getRecipesByTag({required String tag}) async {
    try {
      List<RecipeModel> recipesByTag = [];

      final response = await dio.get(
        '${ApiEndPoint.randomRecpies}?number=10&include-tags=$tag',
      );
      if (response.statusCode! <= 299 && response.statusCode! >= 200) {
        final data = response.data['recipes'] as Iterable;

        recipesByTag =
            data.map((value) => RecipeModel.fromJson(value)).toList();
      }

      return recipesByTag;
    } catch (e) {
      // Get.snackbar('Error Message', e.toString());
      return null;
    }
  }

  Future<List<RecipeModel>?> getRandomRecipes() async {
    try {
      List<RecipeModel> randomRecipes = [];

      final response = await dio.get('${ApiEndPoint.randomRecpies}?number=10');
      if (response.statusCode! <= 299 && response.statusCode! >= 200) {
        final data = response.data['recipes'] as Iterable;

        randomRecipes =
            data.map((value) => RecipeModel.fromJson(value)).toList();
      }

      return randomRecipes;
    } catch (e) {
      // Get.snackbar('Error Message', e.toString());
      return null;
    }
  }

  Future<List<RecipeModel>?> searchRecipesByIngredients({
    required String searchWord,
  }) async {
    try {
      List<RecipeModel> searchRecipes = [];

      final response = await dio.get(
        '${ApiEndPoint.findRecipesByIngredients}?ingredients=$searchWord&number=10',
      );
      if (response.statusCode! <= 299 && response.statusCode! >= 200) {
        final data = response.data as Iterable;

        searchRecipes =
            data.map((value) => RecipeModel.fromJson(value)).toList();
      }

      return searchRecipes;
    } catch (e) {
      // Get.snackbar('Error Message', e.toString());
      return null;
    }
  }

  Future<RecipeModel?> getRecipeDetial({required int id}) async {
    try {
      final response = await dio.get('$id/${ApiEndPoint.recipeInformation}');
      if (response.statusCode! <= 299 && response.statusCode! >= 200) {
        final data = response.data;
        return RecipeModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      // Get.snackbar('Error Message', e.toString());
      return null;
    }
  }
}
