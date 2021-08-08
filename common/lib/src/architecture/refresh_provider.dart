import 'package:common/common.dart';

import 'architecture.dart';

/**
 * refresh_actuator.dart
 * 下拉刷新相关
 * @author: Ruoyegz
 * @date: 2021/7/22
 */
class RefreshProvider {
  /// 页码
  int page = 1;

  /// 刷新
  Refreshable refreshable;

  /// 刷新类型
  PullType pullType = PullType.Both;

  /// 刷新 UI 回调
  RefreshComplete refreshComplete;

  RefreshProvider(this.refreshable, this.refreshComplete);

  /**
   * 刷新数据源
   */
  void refreshSource() async {
    page = 1;
    pullType = PullType.Down;

    LogDog.i("RefreshProvider, refreshSource: ${page} : ${pullType}");

    refreshable.onRefreshSource(page, pullType);
  }

  /**
   * 加载数据源
   */
  void loadMoreSource() async {
    page++;
    pullType = PullType.Up;

    LogDog.i("RefreshProvider, loadMoreSource: ${page} : ${pullType}");

    await refreshable.onLoadMoreSource(page, pullType);
  }

  /**
   * 刷新完成，通知更新 UI
   */
  void refreshCompleted(PullType type) {
    if (refreshComplete != null) {
      refreshComplete.call(type);
    }
  }
}
