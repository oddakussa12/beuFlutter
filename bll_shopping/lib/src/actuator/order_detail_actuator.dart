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

  // late Order order;

  ///late Order order;

  /// 订单 id
  late String orderId = "";

  @override
  void dispose() {
    super.dispose();
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
        order.currency = TextHelper.clean(order.currency);

        order.coast = ValueFormat.cleanDouble(order.coast);

        /// 计算订单总价【有折扣时按折扣价计算】
        if (order.packageCoast != null) {
          LogDog.w(
              "loadOrderDetail: ${order.packageCoast.runtimeType} - ${order.packageCoast}");

          if (order.packageCoast is String) {
            order.total = (order.totalPrice! +
                order.coast! +
                ValueFormat.parseDouble(order.packageCoast));
          } else if (order.packageCoast is double) {
            order.total =
                (order.totalPrice! + order.coast! + order.packageCoast);
          } else {
            order.total = (order.totalPrice! + order.coast!);
          }
        } else {
          order.total = (order.totalPrice! + order.coast!);
        }

        order.formatCoast =
            "${ValueFormat.formatDouble(order.coast)} ${order.currency}";

        order.formatTotal =
            "${ValueFormat.formatDouble(order.total)} ${order.currency}";
      }
    }, fail: (message, error) {
      LogDog.w("loadOrderDetail, message: ${message}", error);
      notifyToasty(S.of(context).alltip_loading_error);
    }, complete: () {
      emptyStatus = order == null ? EmptyStatus.Empty : EmptyStatus.Normal;
      notifySetState();
    });
  }
}
