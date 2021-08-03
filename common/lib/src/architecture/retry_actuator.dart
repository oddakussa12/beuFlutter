import 'package:common/src/architecture/react_actuator.dart';
import 'package:flutter/material.dart';
import 'package:origin/origin.dart';
import 'package:resources/resources.dart';

import 'architecture.dart';
import 'empty_status.dart';
import 'retry_provider.dart';

/**
 * 可重试的执行器
 * @author: Ruoyegz
 * @date: 2021/7/22
 */
abstract class RetryActuator<V extends Viewer> extends ReactActuator<V>
    implements Actuator<V>, Viewer, Retryable {
  /// 重试提供者
  RetryProvider? retryProvider;

  /// 空状态
  EmptyStatus emptyStatus = EmptyStatus.Normal;

  /// 在 page 中判断当前状态是否正常
  bool isNotNormal() {
    return emptyStatus != EmptyStatus.Normal;
  }

  /// 将当前状态改为加载并通知到 page
  void changeStatusForLoading() {
    notifySetState(() {
      emptyStatus = EmptyStatus.Loading;
    });
  }

  @override
  void attach(BuildContext context, V view) {
    super.attach(context, view);

    /// 初始化重试器
    retryProvider = new RetryProvider(
        message: S.of(context).alltip_loading_error,
        retryCall: () {
          changeStatusForLoading();

          /// 执行具体的重试逻辑
          toRetry();
        });
  }

  @override
  void dispose() {
    super.dispose();
    if (retryProvider != null) {
      retryProvider!.dispose();
    }
  }

  /// 点击重试【重试事件的发起】
  void tapRetry() {
    LogDog.i("RetryActuator, tapRetry");
    if (retryProvider != null) {
      retryProvider!.toRetry();
    }
  }
}
