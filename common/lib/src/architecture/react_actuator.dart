import 'dart:async';

import 'package:flutter/material.dart';
import 'package:origin/origin.dart';

import 'architecture.dart';

/**
 * 可响应的执行器
 * @author: Ruoyegz
 * @date: 2021/7/22
 */
abstract class ReactActuator<V extends Viewer> implements Actuator<V>, Viewer {

  /// 视图
  V? viewer;

  /// 上下文
  late BuildContext context;

  /// EventBus 事件流收集器
  List<StreamSubscription> eventSubscriptions = [];

  @override
  void attach(BuildContext context, V view) {
    LogDog.i(this.runtimeType.toString() + ", attach");

    this.context = context;
    this.viewer = view;
  }

  void appendSubscribe(StreamSubscription subscription) {
    if (!eventSubscriptions.contains(subscription)) {
      eventSubscriptions.add(subscription);
    }
  }

  @override
  void dispose() {
    LogDog.i(this.runtimeType.toString() + ", dispose");
    viewer = null;
    if (eventSubscriptions.isNotEmpty) {
      eventSubscriptions.map((e) => e.cancel());
      eventSubscriptions.clear();
    }
  }

  @override
  void notifySetState([VoidCallback? callback]) {
    LogDog.i(this.runtimeType.toString() + ", notifySetState");
    if (viewer != null) {
      viewer!.notifySetState(callback);
    }
  }

  @override
  void notifyToasty(String content) {
    LogDog.i(this.runtimeType.toString() + ", notifyToasty: ${content}");
    if (viewer != null && TextHelper.isNotEmpty(content)) {
      viewer!.notifyToasty(content);
    }
  }
}
