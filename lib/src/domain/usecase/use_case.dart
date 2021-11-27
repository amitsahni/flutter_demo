import 'package:f_d/src/data/model/data_result.dart';
import 'package:f_d/src/data/model/recipe_model.dart';
import 'package:f_d/src/domain/repository/recipe_repository.dart';

import 'base/base_use_case.dart';

class MovieUseCase extends UseCase<Map<String, dynamic>,DataResult<List<RModel>>> {

  final RecipeRepository _recipeRepository;

  MovieUseCase(this._recipeRepository);

  @override
  Future<DataResult<List<RModel>>> executes({Map<String, dynamic> input = const {}}) async {
    return _recipeRepository.fetchMediaList();
  }
}

