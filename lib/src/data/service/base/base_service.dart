import 'package:dio/dio.dart';
import 'package:f_d/src/data/model/data_result.dart';
import 'package:koin/koin.dart';

abstract class BaseService extends KoinComponent{
  final String mediaBaseUrl = "http://www.omdbapi.com/";

  Future<DataResult<dynamic>> getCall(String url,
      {Map<String, dynamic> queryParameters = const {},
      Map<String, dynamic> headers = const {}}) async {
    var dio = get<Dio>();
    if(headers.isNotEmpty) {
      dio.options.headers = headers;
    }
    if(queryParameters.isNotEmpty) {
      dio.options.queryParameters = queryParameters;
    }
    try {
      var result = await dio.get(url);
      return returnResponse(result);
    } on DioError catch(e){
      return DataResult.failure(FetchDataException(
          'Check your internet connection'));
    }
  }

  Future<DataResult<dynamic>> postCall(String url,
      {Map<String, dynamic> queryParameters = const {},
      Map<String, dynamic> body = const {},
      Map<String, dynamic> headers = const {}}) async {
    var dio = get<Dio>();
    if(headers.isNotEmpty) {
      dio.options.headers = headers;
    }
    if(queryParameters.isNotEmpty) {
      dio.options.queryParameters = queryParameters;
    }
    try {
      var result = await dio.post(url, data: body);
      return returnResponse(result);
    } on DioError catch(e){
      return DataResult.failure(FetchDataException(
          'Check your internet connection'));
    }
  }

  dynamic returnResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
        var responseBody = response.data;
        return DataResult.success(responseBody);
      case 400:
        return DataResult.failure(BadRequestException(response.data.toString()));
      case 401:
      case 403:
      return DataResult.failure(UnauthorisedException(response.data.toString()));
      case 500:
      default:
      return DataResult.failure(FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}'));
    }
  }
}

Dio getDio(String baseUrl) {
  var dio = Dio();
  dio.options.baseUrl = baseUrl;
  dio.options.connectTimeout = 5000;
  dio.options.receiveTimeout = 3000;
  dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  return dio;
}
