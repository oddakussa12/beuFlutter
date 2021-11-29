import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:origin/origin.dart';
import 'package:request/src/dio_logger_interceptor.dart';
import 'package:request/src/service_error.dart';
import 'dio_header_interceptor.dart';

/// 请求解析回调
typedef Parser<T> = T Function(Response response);

/**
 * dio_client.dart
 *
 * @author: Ruoyegz
 * @date: 2021/7/23
 */
class DioClient {
  /// 抓包用的 http 域名
  static final String CAUGHT_TEST_BASE_URL =
      "http://test.api.helloo.mantouhealth.com";

  /// 测试 url
  static final String TEST_BASE_URL =
      "https://test.api.helloo.mantouhealth.com";

  static final String TEST_HTTP_URL = "http://test.jonas.projectmantou.com";

  /// 正式 url
  static final String PRO_BASE_URL = "https://api.helloo.mantouhealth.com";
  // static final String PRO_BASE_URL = "http://192.168.1.111";

  /// 文件下载地址
  static final String DOWNLOAD_BASE_URL = "https://qneventsource.mmantou.cn";

  /// Sentry DSN
  static final String SENTRY_DSN =
      "https://f33d4a898e5b47e9a9d0a2414251ee4a@o822294.ingest.sentry.io/5858692";

  static final String ERR_MESSAGE = "The given data was invalid.";

  /// Dio 实例
  Dio _dio = new Dio();

  /// baseUrl
  String baseUrl = "";

  /// 头追加器
  HttpHeaderAppender? appender;

  /// Http 头拦截器
  HttpHeaderInterceptor? headerInterceptor;

  /// 单例
  static DioClient _instance = DioClient._internal();

  factory DioClient() => _instance;

  DioClient._internal() {
    baseUrl = defBaseUrl();

    headerInterceptor = HttpHeaderInterceptor();
    _dio
      ..options = new BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 1000 * 60,
        receiveTimeout: 1000 * 60 * 60 * 24,
        responseType: ResponseType.json,
      )
      ..interceptors.add(headerInterceptor!)
      ..interceptors.add(HttpLogDogInterceptor());

    /// 抓包配置【必须在开发环境，线上打死也不用这几行代码，切记】
    if (Constants.isDevelop && Constants.isTesting && Constants.isCaught) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          LogDog.w("DioClient，findProxy: ${uri}");

          if (uri.isScheme("https")) {
            return "DIRECT";
          }
          return "PROXY 192.168.31.201:8888";
        };
      };
    }
  }

  static DioClient self() {
    return DioClient._internal();
  }

  /// 动态获取 url
  static String defBaseUrl() {
    if (Constants.isDevelop || Constants.isTesting) {
      if (Constants.isCaught) {
        return CAUGHT_TEST_BASE_URL;
      }

      return TEST_BASE_URL;
    } else {
      return PRO_BASE_URL;
    }
  }

  get getBaseUrl => this._dio.options.baseUrl;

  /// 初始化 Http 配置
  void init({String? baseUrl, HttpHeaderAppender? appender}) {
    if (TextHelper.isNotEmpty(baseUrl)) {
      this.baseUrl = baseUrl!;
      this._dio.options.baseUrl = baseUrl;
    }
    if (appender != null && headerInterceptor != null) {
      headerInterceptor!.setAppender(appender);
    }
  }

  /// 通用的 GET 请求
  get<T>(String url, Parser<T> parser,
      {Map<String, dynamic>? query,
      Options? options,
      Success<T>? success,
      Failure? fail,
      Complete? complete}) async {
    try {
      if (url != null && url.startsWith("http")) {
        this._dio.options.baseUrl = "";
      } else {
        if (TextHelper.isEmpty(this._dio.options.baseUrl) &&
            TextHelper.isNotEmpty(baseUrl)) {
          this._dio.options.baseUrl = baseUrl;
        }
      }

      Response response = await _dio.get(url,
          queryParameters: query,
          options: options, onReceiveProgress: (count, total) {
        LogDog.i(
            "DioClient-get: ${url}, count: ${count} : ${total} : ${count / total * 100}%");
      });
      if (response != null) {
        if (response.data is DioError) {
          var error = response.data['code'];
          String message = await parseServiceError(error);
          if (fail != null) {
            fail.call(message, error);
          }
        } else {
          T result = parser.call(response);

          if (success != null) {
            success.call(result);
          }
        }
      }
    } on DioError catch (e) {
      String message = await parseServiceError(e);
      if (fail != null) {
        fail.call(message, e);
      }
    } on Error catch (e) {
      LogDog.w("DioClient, Error: ${e}", e, e.stackTrace);
      if (fail != null) {
        fail.call("Unknown error", Exception(e.toString()));
      }
    }
    if (complete != null) {
      complete.call();
    }
  }

  /// 通用的 POST 请求
  post<T>(String url, Parser<T> parser,
      {Map<String, dynamic>? query,
      dynamic? body,
      Options? options,
      Success<T>? success,
      Failure? fail,
      Complete? complete}) async {
    Response response;
    try {
      if (url != null && url.startsWith("http")) {
        this._dio.options.baseUrl = "";
      } else {
        if (TextHelper.isEmpty(this._dio.options.baseUrl) &&
            TextHelper.isNotEmpty(baseUrl)) {
          this._dio.options.baseUrl = baseUrl;
        }
      }

      response = await _dio.post(url,
          queryParameters: query,
          data: body,
          options: options, onReceiveProgress: (count, total) {
        LogDog.i(
            "DioClient-post: ${url}, count: ${count} : ${total} : ${count / total * 100}%");
      });
      if (response != null) {
        if (response.data is DioError) {
          var error = response.data['code'];
          String message = await parseServiceError(error);
          if (fail != null) {
            fail.call(message, error);
          }
        } else {
          T result = parser.call(response);
          if (success != null) {
            success.call(result);
          }
        }
      }
    } on DioError catch (e) {
      String message = await parseServiceError(e);
      if (fail != null) {
        fail.call(message, e);
      }
    } on Error catch (e) {
      LogDog.w("DioClient, Error: ${e}", e, e.stackTrace);
      if (fail != null) {
        fail.call("Unknown", Exception(e.toString()));
      }
    }
    if (complete != null) {
      complete.call();
    }
  }

  patch<T>(String url, Parser<T> parser,
      {Map<String, dynamic>? query,
      dynamic? body,
      Options? options,
      Success<T>? success,
      Failure? fail,
      Complete? complete}) async {
    Response response;
    try {
      if (url != null && url.startsWith("http")) {
        this._dio.options.baseUrl = "";
      } else {
        if (TextHelper.isEmpty(this._dio.options.baseUrl) &&
            TextHelper.isNotEmpty(baseUrl)) {
          this._dio.options.baseUrl = baseUrl;
        }
      }

      response = await _dio.patch(url,
          queryParameters: query,
          data: body,
          options: options, onReceiveProgress: (count, total) {
        LogDog.i(
            "DioClient-post: ${url}, count: ${count} : ${total} : ${count / total * 100}%");
      });
      if (response != null) {
        if (response.data is DioError) {
          var error = response.data['code'];
          String message = await parseServiceError(error);
          if (fail != null) {
            fail.call(message, error);
          }
        } else {
          T result = parser.call(response);
          if (success != null) {
            success.call(result);
          }
        }
      }
    } on DioError catch (e) {
      String message = await parseServiceError(e);
      if (fail != null) {
        fail.call(message, e);
      }
    } on Error catch (e) {
      LogDog.w("DioClient, Error: ${e}", e, e.stackTrace);
      if (fail != null) {
        fail.call("Unknown", Exception(e.toString()));
      }
    }
    if (complete != null) {
      complete.call();
    }
  }

  /// 通用的 GET 请求
  put<T>(String url, Parser<T> parser,
      {Map<String, dynamic>? query,
      dynamic? body,
      Options? options,
      Success<T>? success,
      Failure? fail,
      Complete? complete}) async {
    try {
      if (url != null && url.startsWith("http")) {
        this._dio.options.baseUrl = "";
      } else {
        if (TextHelper.isEmpty(this._dio.options.baseUrl) &&
            TextHelper.isNotEmpty(baseUrl)) {
          this._dio.options.baseUrl = baseUrl;
        }
      }

      Response response = await _dio.put(url,
          queryParameters: query,
          data: body,
          options: options, onReceiveProgress: (count, total) {
        LogDog.i(
            "DioClient-get: ${url}, count: ${count} : ${total} : ${count / total * 100}%");
      });
      if (response != null) {
        if (response.data is DioError) {
          var error = response.data['code'];
          String message = await parseServiceError(error);
          if (fail != null) {
            fail.call(message, error);
          }
        } else {
          T result = parser.call(response);
          if (success != null) {
            success.call(result);
          }
        }
      }
    } on DioError catch (e) {
      String message = await parseServiceError(e);
      if (fail != null) {
        fail.call(message, e);
      }
    } on Error catch (e) {
      LogDog.w("DioClient, Error: ${e}", e, e.stackTrace);
      if (fail != null) {
        fail.call("Unknown", Exception(e.toString()));
      }
    }
    if (complete != null) {
      complete.call();
    }
  }

  /**
   * 收集 Error 信息
   */
  static Future<String> parseServiceError(DioError error) async {
    if (error != null) {
      SentryHelper.caught(error, stackTrace: error.stackTrace);
      if (Constants.isDebug) {
        if (error.message != null) {
          LogDog.d("DioError-message: ${error.message}");
        }
        if (error.error != null) {
          LogDog.d("DioError-error: ", error.error);
        }
        if (error.stackTrace != null) {
          LogDog.e("DioError-stackTrace: ", error, error.stackTrace);
        }
        if (error.response != null) {
          LogDog.d("DioError-response: ${error.response}");
        }
      }
      if (error.response != null && error.response!.data != null) {
        ServiceError serviceError = ServiceError.fromJson(error.response!.data);
        if (serviceError != null) {
          /// 1. 取 errors 中的信息
          if (serviceError.errors != null && serviceError.errors!.isNotEmpty) {
            for (List<String> value in serviceError.errors!.values) {
              if (value != null &&
                  value.isNotEmpty &&
                  TextHelper.isNotEmpty(value[0])) {
                LogDog.d("DioError-serviceError-error: ${value[0]}");
                return value[0];
              }
            }
          }

          /// 2. 取 message 中的信息
          if (!TextHelper.isEmpty(serviceError.message) &&
              !TextHelper.isEqual(ERR_MESSAGE, serviceError.message)) {
            LogDog.d("DioError-serviceError-message: ${serviceError.message}");
            return serviceError.message!;
          }
        }
      }
    }
    return "";
  }
}
