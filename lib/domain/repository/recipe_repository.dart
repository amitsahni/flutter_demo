import 'package:f_d/data/model/recipe_model.dart';

abstract class RecipeRepository {
  Future<List<RModel>> fetchMediaList(String value);
}
