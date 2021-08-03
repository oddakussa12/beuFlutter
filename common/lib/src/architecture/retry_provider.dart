import 'dart:async';

import 'package:common/common.dart';
import 'package:origin/origin.dart';

import 'architecture.dart';


/// 重试回调方法
typedef RetryCallback = void Function();

/**
 * 重试提供者
 * @author: Ruoyegz
 * @date: 2021/7/7
 */
class RetryProvider implements Retryable {
  /// 最大的重试次数
  int maxRetryCount = 2;

  /// 重试计数器
  int retryCount = 0;

  /// 重试次数满后，等待多久可再次重试
  Duration? retryWaitTime;

  /// 等待计时器
  Timer? waitTimer;

  /// 重试提示信息
  String? message;

  /// 重试回调
  RetryCallback? retryCall;

  RetryProvider(
      {this.maxRetryCount = 3,
      this.retryWaitTime = const Duration(seconds: 10),
      this.message,
      this.retryCall});

  @override
  void toRetry() {
    LogDog.i("RetryProvider, toRetry: ${retryCount} : ${maxRetryCount}");

    if (retryCount >= maxRetryCount) {
      if (waitTimer != null && waitTimer!.isActive) {
        return;
      }
      if (TextHelper.isEmpty(message)) {
        message = "Please try again later!";
      }

      toast(message: message!);
      waitTimer = Timer(Duration(seconds: 15), () {
        retryCount = 0;
      });
    } else {
      retryCount++;
      if (retryCall != null) {
        retryCall!.call();
      }
    }
  }

  void dispose() {
    if (waitTimer != null) {
      waitTimer!.cancel();
    }
  }
}
