import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'base/app_exception.dart';
import 'base/base_service.dart';
import 'package:f_d/src/data/service/base/base_service.dart';

class RecipeService extends BaseService {

  @override
  Future<dynamic> getResponse(String url) async {
    dynamic responseJson;
    try {
      var finalUrl = Uri.parse(mediaBaseUrl + url);
      debugPrint('url $finalUrl');
      final response = await Dio().get(finalUrl.toString());
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
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