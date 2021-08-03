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

  void cleanMyOrders(){
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
  }

  @override
  void onRefreshSource(int page, PullType type) {
    _loadMyOrders(page, type);
  }

  @override
  void onLoadMoreSource(int page, PullType type) {
    _loadMyOrders(page, type);
  }

  void _loadMyOrders(int page, PullType type) async {
    DioClient().get("${CentreUrl.myOrders}?page=${page}",
        (response) => MyOrdersBody.fromJson(response.data),
        success: (MyOrdersBody body) {
      if (body != null && body.data != null) {
        if (page <= 1) {
          myOrders.clear();
        }
        myOrders.addAll(body.data);
      }
    }, complete: () {
      notifySetState();
    });
  }
}
