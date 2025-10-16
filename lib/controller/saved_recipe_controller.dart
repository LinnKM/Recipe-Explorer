import 'dart:convert';

import 'package:get/get.dart';
import 'package:recipe_explorer/model/recipe_model.dart';
import 'package:recipe_explorer/service/sp%20services/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedRecipeController extends GetxController {
  bool isLoading = false;
  bool isSavedRecipe = false;
  List<int> savedIds = [];
  List<RecipeModel> savedRecipes = [];

  // Get all saved Recipes
  Future<void> getSavedRecipes() async {
    isLoading = true;
    update();

    final pref = await SharedPreferences.getInstance();
    final data = pref.getStringList(SharedPreferencesKeys.savedRecipes);
    if (data != null) {
      savedRecipes =
          data.map((value) => RecipeModel.fromJson(jsonDecode(value))).toList();
      savedIds = savedRecipes.map((value) => value.id).toList();
      update();
    }

    isLoading = false;
    update();
  }

  // Save Signle Recipe
  Future<void> saveRecipe(RecipeModel recipe) async {
    final pref = await SharedPreferences.getInstance();
    savedRecipes.add(recipe);
    update();

    final updatedData =
        savedRecipes.map((value) => jsonEncode(value.toJson())).toList();
    await pref.setStringList(SharedPreferencesKeys.savedRecipes, updatedData);
  }

  // Remove Recipe by Id
  Future<void> removeRecipeById(int id) async {
    final pref = await SharedPreferences.getInstance();
    savedIds.remove(id);
    savedRecipes.removeWhere((value) => value.id == id);
    update();

    final updatedData =
        savedRecipes.map((value) => jsonEncode(value.toJson())).toList();
    await pref.setStringList(SharedPreferencesKeys.savedRecipes, updatedData);
  }

  // Toggle BookMark Button
  Future<void> toggleSave(RecipeModel recipe) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(SharedPreferencesKeys.savedRecipes) ?? [];

    if (savedIds.contains(recipe.id)) {
      savedIds.remove(recipe.id);
      savedRecipes.removeWhere((value) => value.id == recipe.id);
      data.removeWhere((json) {
        final data = RecipeModel.fromJson(jsonDecode(json));
        return data.id == recipe.id;
      });
    } else {
      savedIds.add(recipe.id);
      savedRecipes.add(recipe);
      data.add(jsonEncode(recipe.toJson()));
    }

    await prefs.setStringList(SharedPreferencesKeys.savedRecipes, data);
    update();
  }

  // Check is recipe saved
  bool isSaved(int id) => savedIds.contains(id);
}
