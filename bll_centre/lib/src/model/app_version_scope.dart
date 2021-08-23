import 'dart:async';

import 'package:centre/src/centre_config.dart';
import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';

/// 版本更新回调
typedef UpdateCallback = void Function(VersionInfo info);

/**
 * app 版本检查
 */
class AppVersionScope {
  static final String KEY_LAST_CHECK_TIME = "lastCheckingTime";

  /// 最大的重试时间【16小时】
  static final int MAX_RETRY_TIME = 16 * 60 * 60 * 1000;

  /// 默认版本信息
  VersionInfo version = VersionInfo.none();

  /// 上次检查时间
  int lastCheckingTime = 0;

  /// 延时计时器
  Timer? delayTimer;

  /**
   * 提供给后台进行延时检查【主页】
   */
  void delayCheckVersion(BuildContext context, UpdateCallback callback) async {
    if (lastCheckingTime <= 0) {
      lastCheckingTime = await Storage.getInt(KEY_LAST_CHECK_TIME) ?? 0;
    }

    int nowTime = DateTime.now().millisecondsSinceEpoch;
    if (MAX_RETRY_TIME < nowTime - lastCheckingTime) {
      if (delayTimer != null && delayTimer!.isActive) {
        return;
      }
      delayTimer = Timer(Duration(seconds: 10), () {
        checkVersion(context, callback, showToast: false);
      });
    }
  }

  void checkVersion(BuildContext context, UpdateCallback callback,
      {bool? showToast}) {
    DioClient().get(
        CentreUrl.appVersion, (response) => VersionBody.fromJson(response.data),
        success: (VersionBody body) {
      if (body != null && body.data != null) {
        Storage.putInt(
            KEY_LAST_CHECK_TIME, DateTime.now().millisecondsSinceEpoch);
        version = body.data;
        version.isNone = false;
      }
    }, complete: () {
      /// 需要更新版本
      if (version.isUpgrade || version.mustUpgrade) {
        callback.call(version);
      } else {
        if (showToast != null && showToast) {
          toast(message: S.of(context).setupdata_mostnew);
        }
      }
    });
  }

  void dispose() {
    if (delayTimer != null) {
      delayTimer!.cancel();
    }
  }
}
