import 'package:flutter/material.dart';

/// 全局通用的下拉刷新 | 上拉加载 完成回调
typedef RefreshComplete = void Function(PullType type);

/**
 * architecture.dart
 * 执行器
 * @author: Ruoyegz
 * @date: 2021/7/22
 */
class Actuator<V extends Viewer> {
  /// 视图
  V? viewer;

  /// Context
  late BuildContext context;

  void attachViewer(V view) {}

  void attachContext(BuildContext context) {}

  void dispose() {}
}

/**
 * architecture.dart
 * 视图层
 * @author: Ruoyegz
 * @date: 2021/7/22
 */
class Viewer {
  void notifySetState([VoidCallback? callback]) {}

  void notifyToasty(String content) {}
}

/**
 * architecture.dart
 * 重试接口
 * @author: Ruoyegz
 * @date: 2021/7/22
 */
class Retryable {
  toRetry() {}
}

/**
 * core_arch.dart
 * 刷新
 * @author: Ruoyegz
 * @date: 2021/7/7
 */
class Refreshable {
  /**
   * 刷新数据源
   */
  onRefreshSource(int page, PullType type) {}

  /**
   * 加载数据源
   */
  onLoadMoreSource(int page, PullType type){}
}

/**
 * refresh_type.dart
 * 刷新状态
 * @author: Ruoyegz
 * @date: 2021/7/22
 */
enum PullType {
  ///
  Both,
  Down,
  Up
}
