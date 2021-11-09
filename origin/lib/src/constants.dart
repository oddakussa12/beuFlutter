import 'package:flutter/material.dart';

class Constants {
  static final String UserAgreement =
      "https://xmt.notion.site/beU-User-Agreement-7009cbc9f2584cc18a0ba00c055523f8";
  static final String PrivacyPolicy =
      "https://xmt.notion.site/beU-Privacy-Policy-3864d0d1035c483982f5bcbc9052169b";

  /// app id
  static final String IOS_APP_ID = "1577071426";
  static final String ANDROID_APP_ID = "com.xmt.beu.applite";

  /// DEBUG：按 Build type 确定是否为 Debug
  static final bool isDebug = false;

  /// DEV: 开发模式【手动设置】
  static final bool isDevelop = false;

  /// TESTING: 测试模式【手动设置】
  static final bool isTesting = true;

  /// 抓包专用开关【只在测试 | 开发环境有用】
  static final bool isCaught = true;

  static String languageCode = "en";

  /// 应用版本号
  static String appVersion = "1.1.1";

  static String deviceId = "";

  static BuildContext? context;
}
