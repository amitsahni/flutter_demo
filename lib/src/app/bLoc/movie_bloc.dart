import 'dart:async';

import 'package:f_d/src/data/model/data_result.dart';
import 'package:f_d/src/data/model/recipe_model.dart';
import 'package:f_d/src/domain/repository/recipe_repository.dart';
import 'package:f_d/src/domain/usecase/use_case.dart';
import 'package:flutter/material.dart';

import 'base/bloc_provider.dart';

class MovieBloc implements Bloc {
  final MovieUseCase _movieUseCase;

  MovieBloc(this._movieUseCase);

  final _movieController = StreamController<DataResult<RModel>>();

  Stream<DataResult<RModel>> get locationStream => _movieController.stream;

  @override
  void initState() async {
    //final results = await _movieUseCase.executes();
    //_movieController.sink.add(results);
  }

  void fetchMovies(String query) async {
    final results = await _movieUseCase.executes();
    _movieController.sink.add(results);
  }

  void update(List<Search> item){
   _movieController.sink.add(DataResult.success(RModel()..list = item));
  }

  @override
  void dispose() {
    _movieController.close();
  }
}
