import 'package:f_d/src/app/vm/recipe_vm.dart';
import 'package:f_d/src/data/repositoryImpl/recipe_repository.dart';
import 'package:f_d/src/data/service/base/base_service.dart';
import 'package:f_d/src/data/service/recipe_service.dart';
import 'package:f_d/src/domain/bLoc/movie_bloc.dart';
import 'package:f_d/src/domain/repository/recipe_repository.dart';
import 'package:f_d/src/domain/usecase/use_case.dart';
import 'package:koin/koin.dart';

final myModule = Module()
  ..factory((s) => RecipeViewModel(s.get()))
  ..factory((s) => MovieUseCase(s.get()))
  ..factory((scope) => MovieBloc(scope.get()))
  ..single((scope) => getDio('http://www.omdbapi.com/'))
  ..single<RecipeRepository>((s) => RecipeRepositoryImpl(s.get()))
  ..single((scope) => RecipeService());
