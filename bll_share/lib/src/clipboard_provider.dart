import 'package:flutter/services.dart';
import 'package:origin/origin.dart';

/**
 * clipboard_provider.dart
 * 剪切板监听器
 * @author: Ruoyegz
 * @date: 2021/7/24
 */
class ClipboardProvider {
  /**
   * 读取剪切板内容
   */
  readData(Success<String> success, {Failure? fail, Complete? complete}) async {
    try {
      ClipboardData? data = await Clipboard.getData("text/plain");
      if (data != null) {
        success.call(data.text ?? "");
      }
    } on Exception catch (e) {
      if (fail != null) {
        fail.call("", e);
      }
    }
    if (complete != null) {
      complete.call();
    }
  }

  /**
   * 将数据写入剪切板
   */
  writeData(String content, {Failure? fail, Complete? complete}) async {
    try {
      if (TextHelper.isNotEmpty(content)) {
        Clipboard.setData(ClipboardData(text: content));
      }
    } on Exception catch (e) {
      if (fail != null) {
        fail.call("", e);
      }
    }
    if (complete != null) {
      complete.call();
    }
  }
}
