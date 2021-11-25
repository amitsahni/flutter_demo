import 'dart:async';

import 'package:f_d/src/data/model/recipe_model.dart';
import 'package:f_d/src/domain/repository/recipe_repository.dart';
import 'package:f_d/src/domain/usecase/use_case.dart';

import 'base/bloc_provider.dart';

class MovieBloc implements Bloc {
  final MovieUseCase _movieUseCase;

  MovieBloc(this._movieUseCase);

  final _movieController = StreamController<List<RModel>>();

  Stream<List<RModel>> get locationStream => _movieController.stream;


  void fetchMovies(String query) async {
    final results = await _movieUseCase.executes();
    _movieController.sink.add(results);
  }

  @override
  void dispose() {
    _movieController.close();
  }
}
