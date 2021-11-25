import 'package:f_d/src/app/vm/recipe_vm.dart';
import 'package:f_d/src/data/repositoryImpl/recipe_repository.dart';
import 'package:f_d/src/data/service/base/base_service.dart';
import 'package:f_d/src/data/service/recipe_service.dart';
import 'package:f_d/src/domain/bLoc/movie_bloc.dart';
import 'package:f_d/src/domain/repository/recipe_repository.dart';
import 'package:koin/koin.dart';

final myModule = Module()
  ..factory((s) => RecipeViewModel(s.get()))
  ..factory((scope) => MovieBloc(scope.get()))
  ..single<RecipeRepository>((s) => RecipeRepositoryImpl(s.get()))
  ..single<BaseService>((scope) => RecipeService());
