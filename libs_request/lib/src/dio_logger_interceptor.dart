import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:origin/origin.dart';

/**
 * Http 日志拦截器
 */
class HttpLogDogInterceptor extends Interceptor {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    LogDog.d("");
    LogDog.d(">>> Request http request info: ");
    LogDog.d(">>> Request BaseUrl: ${options.baseUrl}");
    LogDog.d(">>> Request Path: ${options.path}");
    LogDog.d(">>> Request Method:${options.method}");
    LogDog.d(">>> Request Headers:${options.headers.toString()}");
    LogDog.d(">>> Request Data:${options.data}");
    LogDog.d(">>> Request QueryParameters:${options.queryParameters}");
    LogDog.d("");
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    LogDog.d("");
    LogDog.d(">>> Response http response info: ");
    LogDog.d(">>> Response StatusCode: ${response.statusCode}");
    LogDog.d(">>> Response StatusMessage: ${response.statusMessage}");
    LogDog.d(">>> Response BaseUrl: ${response.requestOptions.baseUrl}");
    LogDog.d(">>> Response Path: ${response.requestOptions.path}");
    LogDog.d(">>> Response Method: ${response.requestOptions.method}");
    LogDog.d(">>> Response Headers: ${response.headers.toString()}");
    LogDog.d(">>> Response Data-encode: ${json.encode(response.data)}");
    LogDog.d("");
    return super.onResponse(response, handler);
  }
}
