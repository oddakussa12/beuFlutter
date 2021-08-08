import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../architecture/architecture.dart';
import '../architecture/refresh_actuator.dart';
import 'retryable_state.dart';

/**
 * refreshable state
 * @author: Ruoyegz
 * @date: 2021/7/22
 */
abstract class RefreshableState<A extends RefreshActuator,
    T extends StatefulWidget> extends RetryableState<A, T> {
  /// 继承 Retry state
  RefreshableState(A actuator) : super(actuator);

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  late RefreshComplete refreshComplete = (state) {
    LogDog.w(this.runtimeType.toString() + ", RefreshCallback");

    if (refreshController != null) {
      if (state == PullType.Down) {
        refreshController.refreshCompleted(resetFooterState: false);
      } else if (state == PullType.Up) {
        refreshController.loadComplete();
      } else {
        refreshController.twoLevelComplete();
      }
    }
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    actuator.appendRefreshCallback(refreshComplete);
  }
}
