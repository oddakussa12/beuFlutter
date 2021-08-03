import 'package:common/common.dart';

import 'architecture.dart';
import 'retry_actuator.dart';
import 'refresh_provider.dart';

/**
 * 下拉刷新执行器
 * @author: Ruoyegz
 * @date: 2021/7/22
 */
abstract class RefreshActuator<V extends Viewer> extends RetryActuator<V>
    implements Refreshable {
  /// 刷新提供者
  late RefreshProvider refreshProvider;

  void appendRefreshCallback(RefreshComplete complete) {
    refreshProvider = RefreshProvider(this, complete);
  }

  /// 下拉调用
  void pullDown() {
    LogDog.i("pullDown");
    if (refreshProvider != null) {
      refreshProvider.refreshSource();
    }
  }

  /// 上拉调用
  void pullUp() {
    LogDog.i("pullUp");
    if (refreshProvider != null) {
      refreshProvider.loadMoreSource();
    }
  }

  @override
  void toRetry() {
    LogDog.i("toRetry");
    pullDown();
  }
}
