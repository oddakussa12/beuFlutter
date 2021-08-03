import 'package:dio/dio.dart';
import 'package:origin/origin.dart';

/// 开发给上层追加 Http header
typedef HttpHeaderAppender = void Function(
    RequestOptions options, RequestInterceptorHandler handler);

/**
 * Dio 网络拦截器
 */
class HttpHeaderInterceptor extends Interceptor {
  /// 头追加器
  HttpHeaderAppender? appender;

  void setAppender(HttpHeaderAppender? appender) {
    this.appender = appender;
  }

  /**
   * options.headers["Authorization"] =
      "${UserManager().getTokenType()} ${UserManager().getToken()}";
   */
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers["deviceId"] = "";
    options.headers["paltid"] = "android-lite";
    options.headers["HellooLiteVersion"] = "1.1.0";
    options.headers["Accept-Language"] = Constants.languageCode;
    options.headers["Content-Type"] = "application/x-www-form-urlencoded";
    options.headers["user-agent"] = "HellooLiteAndroid";
    options.headers["Authorization"] = "";

    if (appender != null) {
      appender!.call(options, handler);
    }
    return super.onRequest(options, handler);
  }
}
