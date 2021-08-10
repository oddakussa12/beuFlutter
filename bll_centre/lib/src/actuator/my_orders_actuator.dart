import 'package:centre/src/centre_config.dart';
import 'package:common/common.dart';

/**
 * MyOrdersActuator
 *
 * @author: Ruoyegz
 * @date: 2021/7/27
 */
class MyOrdersActuator extends RefreshActuator {
  /// 我的订单列表
  List<Order> myOrders = [];

  bool hasUpdated = false;

  void cleanMyOrders() {
    myOrders.clear();
    notifySetState();
  }

  @override
  void dispose() {
    super.dispose();
    myOrders.clear();
  }

  @override
  void toRetry() {
    super.toRetry();
    if (myOrders.isEmpty) {
      changeStatusForLoading();
      pullDown();
    }
  }

  @override
  void onRefreshSource(int page, PullType type) {
    if (myOrders.isEmpty) {
      changeStatusForLoading();
    }
    loadMyOrders(page, type);
  }

  @override
  void onLoadMoreSource(int page, PullType type) {
    if (myOrders.isNotEmpty) {
      loadMyOrders(page, type);
    } else {
      toRetry();
    }
  }

  void loadMyOrders(int page, PullType type) async {
    hasUpdated = false;
    DioClient().get("${CentreUrl.myOrders}?page=${page}",
        (response) => MyOrdersBody.fromJson(response.data),
        success: (MyOrdersBody body) {
      if (body != null && body.data != null && body.data.isNotEmpty) {
        hasUpdated = true;
        if (page <= 1) {
          myOrders.clear();
        }
        myOrders.addAll(body.data);
      }
    }, fail: (message, error) {
      LogDog.w("loadMyOrders, ${message}", error);
    }, complete: () {
      refreshCompleted(type);
      if (hasUpdated || isNotNormal()) {
        emptyStatus = myOrders.isEmpty ? EmptyStatus.Empty : EmptyStatus.Normal;
      }
      notifySetState(() {});
    });
  }
}
