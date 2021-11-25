import 'package:f_d/src/data/model/recipe_model.dart';
import 'package:f_d/src/data/service/recipe_service.dart';
import 'package:f_d/src/domain/repository/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeService _mediaService;

  RecipeRepositoryImpl(this._mediaService);

  @override
  Future<List<RModel>> fetchMediaList({Map<String, dynamic> input = const {}}) async {
    dynamic response =
        await _mediaService.batmanMovies("");
    final Iterable json = response["Search"];
    return json.map((movie) => RModel.fromJson(movie)).toList();
  }
}
