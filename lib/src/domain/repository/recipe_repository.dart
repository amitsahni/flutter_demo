import 'package:f_d/src/data/model/data_result.dart';
import 'package:f_d/src/data/model/recipe_model.dart';

abstract class RecipeRepository {
  Future<DataResult<List<RModel>>> fetchMediaList({Map<String, dynamic> input = const {}});
}
