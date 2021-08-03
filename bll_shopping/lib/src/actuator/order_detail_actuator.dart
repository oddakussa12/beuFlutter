import 'package:common/common.dart';
import 'package:shopping/shopping.dart';

/**
 * OrderDetailActuator
 * 订单详情
 * @author: Ruoyegz
 * @date: 2021/7/31
 */
class OrderDetailActuator extends RetryActuator {
  /// 订单详情
  var order;

  /// 订单 id
  late String orderId = "";

  @override
  void dispose() {
    super.dispose();
    order = null;
  }

  @override
  void toRetry() {
    loadOrderDetail();
  }

  void loadOrderDetail() async {
    if (order == null) {
      changeStatusForLoading();
    }

    String url = "${ShoppingUrl.apiOrder}/${orderId}";
    DioClient().get(url, (response) => OrderDetailBody.fromJson(response.data),
        success: (OrderDetailBody body) {
      if (body != null && body.data != null) {
        order = body.data;

        /// 计算订单价格
        order.currency = TextHelper.clean(order.currency);
        order.formatCoast =
            "${ValueFormat.formatDouble(order.coast)} ${order.currency}";
        order.total = order.price + order.coast;
        order.formatTotal =
            "${ValueFormat.formatDouble(order.total)} ${order.currency}";
      }
    }, fail: (message, error) {
      notifyToasty(S.of(context).alltip_loading_error);
    }, complete: () {
      emptyStatus = order == null ? EmptyStatus.Empty : EmptyStatus.Normal;
      notifySetState(() {});
    });
  }
}
