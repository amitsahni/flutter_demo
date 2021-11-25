import 'base/base_service.dart';
import 'package:f_d/src/data/service/base/base_service.dart';

class RecipeService extends BaseService {

  Future<dynamic> batmanMovies(String url) async {
    var queryParam = {
      "s" : "batman",
      "apikey" : "bbf02d07"
    };
    return getCall("", queryParameters: queryParam);
  }

}
