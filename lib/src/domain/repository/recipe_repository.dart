import 'package:f_d/src/data/model/recipe_model.dart';

abstract class RecipeRepository {
  Future<List<RModel>> fetchMediaList({Map<String, dynamic> input = const {}});
}
