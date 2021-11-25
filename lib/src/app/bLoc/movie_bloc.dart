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

  void update(List<RModel> list) {
    _movieController.sink.add(list);
  }

  @override
  void dispose() {
    _movieController.close();
  }
}

class MovieItemBloc implements Bloc {
  final RModel _movieItem;

  MovieItemBloc(this._movieItem);

  RModel get movieItem => _movieItem;

  final _movieItemController = StreamController<RModel>();

  Stream<RModel> get movieItemStream => _movieItemController.stream;

  void update(RModel list) {
    _movieItemController.sink.add(list);
  }

  @override
  void dispose() {
    _movieItemController.close();
  }
}
