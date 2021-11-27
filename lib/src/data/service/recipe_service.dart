import 'package:f_d/src/data/model/data_result.dart';
import 'package:f_d/src/data/model/recipe_model.dart';

import 'base/base_service.dart';
import 'package:f_d/src/data/service/base/base_service.dart';

class RecipeService extends BaseService {

  dynamic batmanMovies(String url) async {
    var queryParam = {
      "s" : "batman",
      "apikey" : "bbf02d07"
    };
    return await getCall("", queryParameters: queryParam);
  }

}
