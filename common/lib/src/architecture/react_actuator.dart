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
  void attachViewer(V view) {
    LogDog.i(this.runtimeType.toString() + ", attachViewer");
    this.viewer = view;
  }

  @override
  void attachContext(BuildContext context) {
    LogDog.i(this.runtimeType.toString() + ", attachContext");
    this.context = context;
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
  void notifyToasty(String message) {
    LogDog.i(this.runtimeType.toString() + ", notifyToasty: ${message}");
    if (viewer != null && TextHelper.isNotEmpty(message)) {
      viewer!.notifyToasty(message);
    }
  }

  @override
  void showLoading() {
    if (viewer != null) {
      viewer!.showLoading();
    }
  }

  @override
  void dismissLoading() {
    if (viewer != null) {
      viewer!.dismissLoading();
    }
  }
}
