import 'package:f_d/data/repositoryImpl/recipe_repository.dart';
import 'package:f_d/data/service/base/api_response.dart';
import 'package:f_d/domain/repository/recipe_repository.dart';
import 'package:flutter/material.dart';

class RecipeViewModel with ChangeNotifier {
  final RecipeRepository recipeRepository ;

  RecipeViewModel(this.recipeRepository);

  var _apiResponse = ApiResponse.initial();


  ApiResponse get response {
    return _apiResponse;
  }

  Future<void> fetchMediaData(String value) async {
    _apiResponse = ApiResponse.loading('Loading...');
    try {
      var mediaList = await recipeRepository.fetchMediaList(value);
      _apiResponse = ApiResponse.completed(mediaList);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }
}
