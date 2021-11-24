import 'package:dio/dio.dart';
import 'package:f_d/data/model/recipe_model.dart';
import 'package:retrofit/http.dart';
part 'recipe_service_retrofit.g.dart';

@RestApi(baseUrl: "http://www.omdbapi.com/")
abstract class RecipeServiceRetrofit {
  factory RecipeServiceRetrofit(Dio dio, {String baseUrl}) = _RecipeServiceRetrofit;

  @GET("/")
  Future<List<RModel>> getUsers(@Queries() Map<String, dynamic> queries);
}
