import 'package:f_d/src/data/model/recipe_model.dart';
import 'package:f_d/src/domain/repository/recipe_repository.dart';

import 'base/base_use_case.dart';

class MovieUseCase extends UseCase<Map<String, dynamic>,List<RModel>> {

  final RecipeRepository recipeRepository;

  MovieUseCase(this.recipeRepository);

  @override
  Future<List<RModel>> executes({Map<String, dynamic> input = const {}}) async {
    return recipeRepository.fetchMediaList();
  }
}

