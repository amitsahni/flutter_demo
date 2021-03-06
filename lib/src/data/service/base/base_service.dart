import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:koin/koin.dart';

import 'app_exception.dart';

abstract class BaseService extends KoinComponent{
  final String mediaBaseUrl = "http://www.omdbapi.com/";

  Future<dynamic> getCall(String url,
      {Map<String, dynamic> queryParameters = const {},
      Map<String, dynamic> headers = const {}}) async {
    var dio = get<Dio>();
    if(headers.isNotEmpty) {
      dio.options.headers = headers;
    }
    if(queryParameters.isNotEmpty) {
      dio.options.queryParameters = queryParameters;
    }
    var result = await dio.get(url);
    return returnResponse(result);
  }

  Future<dynamic> postCall(String url,
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
    var result =
        await dio.post(url, data: body);
    return returnResponse(result);
  }

  dynamic returnResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
        var responseBody = response.data;
        debugPrint('responseBody $responseBody');
        return responseBody;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.data.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
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
