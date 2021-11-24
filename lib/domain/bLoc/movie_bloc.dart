import 'dart:async';

import 'package:f_d/data/model/recipe_model.dart';
import 'package:f_d/domain/bLoc/base/bloc.dart';
import 'package:f_d/domain/repository/recipe_repository.dart';

class MovieBloc implements Bloc {
  final RecipeRepository recipeRepository;

  MovieBloc(this.recipeRepository);

  final _movieController = StreamController<List<RModel>>();

  Stream<List<RModel>> get locationStream => _movieController.stream;

  void fetchMovies(String query) async {
    final results = await recipeRepository.fetchMediaList(query);
    _movieController.sink.add(results);
  }

  @override
  void dispose() {
    _movieController.close();
  }
}
