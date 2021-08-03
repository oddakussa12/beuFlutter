import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

typedef HomeBuilder = Widget Function(BuildContext context);

/**
 * AppStatelessWidget
 * 全局通用的 App Widget
 * @author: Ruoyegz
 * @date: 2021/7/23
 */
class AppStatelessWidget extends StatelessWidget {
  /// 标题
  final String title;

  /// 本地化
  final Locale? locale;

  /// 主页构造器
  final HomeBuilder builder;

  /// 全局过渡配置
  final TransitionBuilder? transitionBuilder;

  /// 命名路由拦截器
  final RouteFactory? onGenerateRoute;

  /// 路由表
  final Map<String, WidgetBuilder>? routes;

  const AppStatelessWidget(
      {Key? key,
      required this.title,
      required this.builder,
      this.locale,
      this.transitionBuilder,
      this.routes,
      this.onGenerateRoute})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    initAppConfig();
    return OKToast(
        child: MaterialApp(
            title: title,
            color: AppColor.white,
            //routes: routes ?? {},

            onGenerateRoute: onGenerateRoute,
            theme: ThemeData(
              primaryColor: AppColor.white,
              primarySwatch: Colors.red,
            ),

            /// 全局字体配置
            builder: transitionBuilder ??
                (context, widget) {
                  return MediaQuery(
                    // 设置文字大小不随系统设置改变
                    data: MediaQuery.of(context).copyWith(
                        textScaleFactor: PlatformSupport.ios() ? 1.0 : 1.0),
                    child: widget!,
                  );
                },
            locale: locale,

            /// 获取当前设备的语种
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              if (deviceLocale != null &&
                  !TextHelper.isEmpty(deviceLocale.languageCode)) {
                String code = deviceLocale.languageCode;
                if (code == "zh") {
                  Constants.languageCode = "zh-CN";
                } else if (code == "in") {
                  Constants.languageCode = "id";
                } else {
                  Constants.languageCode = "en";
                }
              }
            },

            /// 国际化支持
            localizationsDelegates: const [
              S.delegate,
              // 指定本地化的字符串和一些其他的值
              GlobalMaterialLocalizations.delegate,
              // 对应的Cupertino风格
              GlobalCupertinoLocalizations.delegate,
              // 指定默认的文本排列方向, 由左到右或由右到左
              GlobalWidgetsLocalizations.delegate
            ],

            /// 国际化支持的语言类型
            supportedLocales: S.delegate.supportedLocales,
            home: builder.call(context)));
  }

  /// 初始化 App 配置
  initAppConfig() {
    initPackage();
    DioClient.self();
    DioClient().init(
        appender: (RequestOptions options, RequestInterceptorHandler handler) {
      options.headers["Authorization"] =
          "${UserManager().getTokenType()} ${UserManager().getToken()}";
    });
    try {
      if (PlatformSupport.android()) {
        // 设置android状态栏为透明的沉浸。
        // 写在组件渲染之后，是为了在渲染后进行set赋值，
        // 覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
        SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: AppColor.white,
            statusBarIconBrightness: Brightness.dark);
        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      }
    } catch (e) {
      print("initAppConfig: " + e.toString());
    }

    /// 初始化 用户管理器
    UserManager().initManager();
  }

  void initPackage() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    Constants.appVersion = info.version;
  }
}
