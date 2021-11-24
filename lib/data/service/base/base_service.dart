abstract class BaseService {
  final String mediaBaseUrl = "http://www.omdbapi.com/";

  Future<dynamic> getResponse(String url);

}