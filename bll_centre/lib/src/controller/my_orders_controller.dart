
import 'package:centre/src/pages/my_orders_widget.dart';
import 'package:common/common.dart';

/**
 * my_orders_widget.dart
 * 我的订单控制器
 * @author: Ruoyegz
 * @date: 2021/7/10
 */
class MyOrderController {
  late MyOrdersWidgetState _state;
  late RefreshComplete refreshComplete;

  initState(MyOrdersWidgetState state) {
    this._state = state;
  }

  void refresh() {
    if (_state != null) {
      _state.actuator.pullDown();
    }
  }

  void loadMore() {
    if (_state != null) {
      _state.actuator.pullUp();
    }
  }

  void cleanOrdersByLogout() {
    if (_state != null) {
      _state.actuator.cleanMyOrders();
    }
  }
}
