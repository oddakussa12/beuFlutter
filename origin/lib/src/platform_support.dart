import 'package:flutter/foundation.dart';

/**
 * platform_support.dart
 * 平台支持
 * @author: Ruoyegz
 * @date: 2021/7/19
 */
class PlatformSupport {
  static bool web() {
    return false;
    // return !ios() && !android();
  }

  static bool ios() {
    return defaultTargetPlatform.index == TargetPlatform.iOS;
  }

  static bool android() {
    return defaultTargetPlatform == TargetPlatform.android;
  }

  static bool linux() {
    return defaultTargetPlatform.index == TargetPlatform.linux;
  }

  static bool windows() {
    return defaultTargetPlatform.index == TargetPlatform.windows;
  }

  static bool macOS() {
    return defaultTargetPlatform.index == TargetPlatform.macOS;
  }

  static bool fuchsia() {
    return defaultTargetPlatform.index == TargetPlatform.fuchsia;
  }

  static Future<String> deviceId() async {
    //String? deviceId = await PlatformDeviceId.getDeviceId;
    //return deviceId ?? "";
    return "";
  }
}
