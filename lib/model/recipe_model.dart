class RecipeModel {
  final int id;
  final String image;
  final String title;
  final int readyInMinutes;
  final int servings;
  final List<IngredientsModel> extendedIngredients;
  final String summary;
  final String instructions;
  final int likes;

  const RecipeModel({
    required this.id,
    required this.image,
    required this.title,
    required this.readyInMinutes,
    required this.servings,
    required this.extendedIngredients,
    required this.summary,
    required this.instructions,
    required this.likes,
  });

  factory RecipeModel.fromJson(Map data) {
    final List<IngredientsModel> ingredients = [];
    if (data['extendedIngredients'] != null) {
      for (var data in data['extendedIngredients']) {
        final ingredient = IngredientsModel.fromJson(data);
        ingredients.add(ingredient);
      }
    }

    return RecipeModel(
      id: data['id'],
      image: data['image'],
      title: data['title'],
      readyInMinutes: data['readyInMinutes'] ?? 0,
      servings: data['servings'] ?? 0,
      extendedIngredients: ingredients,
      summary: data['summary'] ?? '',
      instructions: data['instructions'] ?? '',
      likes: data['likes'] ?? 0,
    );
  }
}

class IngredientsModel {
  final int id;
  final String name;

  const IngredientsModel({required this.id, required this.name});

  factory IngredientsModel.fromJson(Map data) {
    return IngredientsModel(id: data['id'], name: data['name']);
  }
}
