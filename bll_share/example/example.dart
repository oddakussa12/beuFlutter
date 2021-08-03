import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:share/src/dialog/share_shop_dialog.dart';
import 'package:share/src/share_client.dart';

void main() {
  runApp(AppStatelessWidget());
}

class AppStatelessWidget extends StatelessWidget {
  const AppStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MaterialApp(
            title: "title",
            color: AppColor.white,
            theme: ThemeData(
              primaryColor: AppColor.white,
              primarySwatch: Colors.red,
            ),
            builder: (context, widget) {
              return MediaQuery(
                // 设置文字大小不随系统设置改变
                data: MediaQuery.of(context).copyWith(
                    textScaleFactor: PlatformSupport.ios() ? 1.0 : 1.0),
                child: widget!,
              );
            },

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
            home: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(20),
              child: GestureDetector(
                child: Text(
                  "Show Dialog",
                  style: TextStyle(color: AppColor.colorF7551D, fontSize: 20),
                ),
                onTap: () {
                  showShopLinkDialog(context, "share");
                },
              ),
            )));
  }

  void showShopLinkDialog(BuildContext context, String share) {
    showDialog(
        context: context,
        builder: (context) {
          return ShareShopDialog();
        });
  }
}
