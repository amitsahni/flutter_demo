// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_service_retrofit.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RecipeServiceRetrofit implements RecipeServiceRetrofit {
  _RecipeServiceRetrofit(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://www.omdbapi.com/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<RModel>> getUsers(queries) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(queries);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<RModel>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => RModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
