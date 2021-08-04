import 'package:common/common.dart';
import 'package:dio/dio.dart';
import 'package:shopping/shopping.dart';
import 'package:shopping/src/entity/user_address.dart';

/**
 * OrderPreviewActuator
 * 订单预览
 * @author: Ruoyegz
 * @date: 2021/7/27
 */
class OrderPreviewActuator extends RetryActuator {
  /// 预览订单项
  final List<PreOrder> orderItems = [];

  /// 当前预览订单
  final PreviewOrdersBody orderP = PreviewOrdersBody([]);

  @override
  void dispose() {
    super.dispose();
    orderItems.clear();
  }

  @override
  void toRetry() {}

  /// 跳转地址编辑页前的准备
  void prepareDeliveryAddress(Success<UserAddress> success) async {
    UserAddress params = UserAddress(
        name: orderP.name, phone: orderP.phone, address: orderP.address);
    if (orderItems.isNotEmpty) {
      List<String> shopIds = [];
      orderItems.forEach((item) {
        if (item.shop != null) {
          shopIds.add(item.shop!.id);
        }
      });
      if (shopIds.isNotEmpty) {
        params.shopIds = shopIds;
      }
    }
    success.call(params);
  }

  /**
   * 加载我的购物车
   */
  void loadPreviewOrder(Map<String, String> idNumbers) async {
    if (idNumbers == null || idNumbers.isEmpty) {
      return;
    }
    if (orderItems.isEmpty) {
      changeStatusForLoading();
    }

    FormData requestBody = FormData.fromMap({"goods": idNumbers});
    DioClient().post(ShoppingUrl.orderPreview,
            (response) => PreviewOrdersBody.fromJson(response.data),
        body: requestBody, success: (PreviewOrdersBody body) {
          if (body != null && body.data != null && body.data.isNotEmpty) {
            orderItems.clear();
            orderItems.addAll(body.data);
            orderP.data = orderItems;
            _processOrderInfo();
          }
        }, complete: () {
          emptyStatus =
          orderItems.isEmpty ? EmptyStatus.Empty : EmptyStatus.Normal;
          notifySetState();
        });
  }

  /**
   * 处理订单信息
   */
  void _processOrderInfo() {
    double previewTotal = 0.0;
    String currency = "";
    bool diffCurrency = false;
    orderItems.forEach((order) {
      order.coast = order.coast == null ? 0.0 : order.coast;
      order.subTotal = order.subTotal == null ? 0.0 : order.subTotal;
      order.currency = order.currency == null ? "" : order.currency;

      /// 计算订单总价
      order.total = (order.subTotal! + order.coast!);
      previewTotal += order.total!;

      order.formatSubTotal =
      "${format.format(order.subTotal)} ${order.currency}";
      order.formatCoast = "${format.format(order.coast)} ${order.currency}";
      order.formatPackageFee =
      "${format.format(order.packageFee)} ${order.currency}";
      order.formatTotal = "${format.format(order.total)} ${order.currency}";

      /// 是否相同币种
      currency = currency == "" ? order.currency! : currency;
      if (!TextHelper.isEqual(currency, order.currency!)) {
        diffCurrency = true;
      }
    });

    orderP.diffCurrency = diffCurrency;
    if (!diffCurrency) {
      orderP.total = previewTotal;
      orderP.formatTotal = "${format.format(previewTotal)} ${currency}";
    } else {
      orderP.total = 0.0;
      orderP.formatTotal = "0.0";
    }
  }

  /**
   * 提交预览的订单
   */
  void checkoutPreviewOrder(Complete complete) async {
    /// 检查预览订单信息
    if (orderP == null || orderItems == null || orderItems.isEmpty) {
      toast(message: S
          .of(context)
          .alltip_loading_error);
      return;
    }

    /// 检查派送地址信息
    if (TextHelper.isEmpty(orderP.name!) ||
        TextHelper.isEmpty(orderP.phone!) ||
        TextHelper.isEmpty(orderP.address!)) {
      toast(message: S
          .of(context)
          .confirm_address_no);
      return;
    }

    /// 商品信息
    Map<String, String> idNumbers = {};
    orderItems.forEach((order) {
      if (order.goods != null) {
        order.goods!.forEach((product) {
          idNumbers["${product.id}"] = "${product.goodsNumber}";
        });
      }
    });

    /// 请求体
    FormData requestBody = FormData.fromMap({
      "user_name": "${orderP.name}",
      "user_contact": "${orderP.phone}",
      "user_address": "${orderP.address}",
      "goods": idNumbers,
    });
    DioClient().post(ShoppingUrl.apiOrder,
            (response) => PreviewOrdersBody.fromJson(response.data),
        body: requestBody, success: (PreviewOrdersBody body) {
          if (body != null && body.data != null) {
            LogDog.d("checkoutPreviewOrder-Response: ${body}");

            /// 订单创建完成
            complete.call();
          } else {
            toast(message: S
                .of(context)
                .alltip_loading_error);
          }
        }, fail: (message, error) {
          notifyToasty(message);
        });
  }
}
