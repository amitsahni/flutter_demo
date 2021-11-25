import 'package:f_d/src/data/model/recipe_model.dart';
import 'package:f_d/src/data/service/base/base_service.dart';
import 'package:f_d/src/data/service/recipe_service.dart';
import 'package:f_d/src/domain/repository/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final BaseService _mediaService;

  RecipeRepositoryImpl(this._mediaService);

  @override
  Future<List<RModel>> fetchMediaList(String value) async {
    dynamic response =
        await _mediaService.getResponse("?s=batman&apikey=bbf02d07");
    final Iterable json = response["Search"];
    return json.map((movie) => RModel.fromJson(movie)).toList();
  }
}
