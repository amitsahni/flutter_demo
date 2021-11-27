import 'package:f_d/src/data/model/data_result.dart';
import 'package:f_d/src/data/model/recipe_model.dart';
import 'package:f_d/src/data/service/recipe_service.dart';
import 'package:f_d/src/domain/repository/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeService _mediaService;

  RecipeRepositoryImpl(this._mediaService);

  @override
  Future<DataResult<List<RModel>>> fetchMediaList(
      {Map<String, dynamic> input = const {}}) async {
    DataResult<dynamic> response = await _mediaService.batmanMovies("");
    var result = response.either((error) => error, (data) {
      final Iterable json = data["Search"];
      var list = json.map((movie) => RModel.fromJson(movie)).toList();
      return list;
    });
    return result;
  }
}
