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
    try {
      LogDog.d(">>> Request Uri: ${options.method} : ${options.uri.toString()}");
      LogDog.d(">>> Request Headers:${options.headers.toString()}");

      if (options.data is FormData) {
        FormData data = options.data as FormData;
        if (data.fields != null && data.fields.isNotEmpty) {
          LogDog.d(">>> Request Data-fields:${data.fields}");
        }
        if (data.files != null && data.files.isNotEmpty) {
          LogDog.d(">>> Request Data-files:${data.files}");
        }
      }
    } catch (e) {
      LogDog.d("HttpLogDogInterceptor, onRequest, Error: ", e);
    }

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    try {
      LogDog.d(
          ">>> Response StatusMessage: ${response.statusCode} : ${response.statusMessage}");
      LogDog.d(">>> Response RealUri: ${response.realUri.toString()}");
      LogDog.d(">>> Response Headers: ${response.headers.toString()}");
      LogDog.d(">>> Response Data-encode: ${json.encode(response.data)}");
    } catch (e) {
      LogDog.d("HttpLogDogInterceptor, onResponse, Error: ", e);
    }
    return super.onResponse(response, handler);
  }
}
