import 'dart:convert';

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
  /// 预览订单类型【特价】
  String type = "";

  /// 配送费参数
  String deliveryCoastParam = "";

  /// googs 参数
  Map<String, String> idNumbers = {};

  /// 优惠码
  String promoCode = "";

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

  /// 判断是否是特价商品
  bool isSpecial() {
    return TextHelper.isEqual("special", type);
  }

  /// 显示 Promo code 提示消息
  bool showPromoMessage() {
    return (orderP.code == 0 && TextHelper.isNotEmpty(promoCode)) ||
        (orderP.code == 200 && TextHelper.isNotEmpty(orderP.message));
  }

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

  /// 用户填写地址后更加经纬度信息更新预览订单
  void updateDeliveryAddress(UserAddress result) {
    orderP.name = result.name;
    orderP.phone = result.phone;
    orderP.address = result.address;
    deliveryCoastParam = result.deliveryCost ?? "";
    orderP.avatar = UserManager().getUser().avatarLink;
    notifySetState();

    /// 从新加载订单信息
    if (idNumbers != null &&
        idNumbers.isNotEmpty &&
        TextHelper.isNotEmpty(deliveryCoastParam)) {
      loadPreviewOrder();
    }
  }

  /// 准备折扣码
  void preparePromoCode() {
    if (TextHelper.isEmpty(promoCode)) {
      notifyToasty("优惠码不能为空");
      return;
    }

    loadPreviewOrder();
  }

  /**
   * 加载我的购物车
   */
  void loadPreviewOrder() async {
    if (idNumbers == null || idNumbers.isEmpty) {
      return;
    }

    this.type = type;
    this.idNumbers = idNumbers;
    if (orderItems.isEmpty) {
      changeStatusForLoading();
    }

    FormData requestBody = FormData.fromMap({"goods": idNumbers});
    if (TextHelper.isNotEmpty(deliveryCoastParam)) {
      requestBody.fields.add(MapEntry("delivery_coast", deliveryCoastParam));
    }
    if (TextHelper.isNotEmpty(type)) {
      requestBody.fields.add(MapEntry("type", type));
    }
    if (!isSpecial() && TextHelper.isNotEmpty(promoCode)) {
      requestBody.fields.add(MapEntry("promo_code", promoCode));
    }

    DioClient().post(ShoppingUrl.orderPreview,
        (response) => PreviewOrdersBody.fromJson(response.data),
        body: requestBody, success: (PreviewOrdersBody body) {
      if (body != null && body.data != null && body.data.isNotEmpty) {
        orderItems.clear();
        orderItems.addAll(body.data);
        orderP.data = orderItems;

        /// 优惠码状态
        if (TextHelper.isNotEmpty(promoCode)) {
          orderP.code = body.code;
          orderP.message = body.message;
        } else {
          orderP.code = null;
          orderP.message = null;
        }
        _processOrderInfo();
      }
    }, fail: (message, error) {
      notifyToasty(message);
    }, complete: () {
      emptyStatus = orderItems.isEmpty ? EmptyStatus.Empty : EmptyStatus.Normal;
      notifySetState();
    });
  }

  /**
   * 处理订单信息
   */
  void _processOrderInfo() {
    String currency = "";
    bool diffCurrency = false;

    double previewTotal = 0.0;
    double previewPackageTotal = 0.0;
    double previewDeliveryTotal = 0.0;
    double previewDiscountTotal = 0.0;

    orderItems.forEach((order) {
      /// 派送费
      order.deliveryCoast =
          order.deliveryCoast == null ? 0.0 : order.deliveryCoast;

      /// 包装费
      order.packageFee = order.packageFee == null ? 0.0 : order.packageFee;

      /// 折扣
      order.subDisTotal = order.subDisTotal == null ? 0.0 : order.subDisTotal;

      order.subTotal = order.subTotal == null ? 0.0 : order.subTotal;
      order.currency = order.currency == null ? "" : order.currency;

      /// 计算所有订单：包装费
      // previewPackageTotal += order.packageFee!;

      /// 计算所有订单：派送费
      // previewDeliveryTotal += order.coast!;

      /// 计算所有订单：折扣
      // previewDiscountTotal += order.subDisTotal!;

      /// 计算订单总价【有折扣时按折扣价计算】
      if (order.subDisTotal != 0) {
        order.total = (order.subDisTotal! + order.deliveryCoast!);
      } else {
        order.total = (order.subTotal! + order.deliveryCoast!);
      }

      /// 计算所有订单：总价
      previewTotal += order.total!;

      /// 格式化
      order.formatSubTotal =
          "${format.format(order.subTotal)} ${order.currency}";
      order.formatDeliveryCoast =
          "${format.format(order.deliveryCoast)} ${order.currency}";
      order.formatPackageFee =
          "${format.format(order.packageFee)} ${order.currency}";
      order.formatSubDisTotal =
          "${format.format(order.subDisTotal)} ${order.currency}";
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

      /// 格式化
      // orderP.formatPackageTotal = "+${format.format(previewPackageTotal)} ${currency}";
      // orderP.formatDeliveryTotal = "+${format.format(previewDeliveryTotal)} ${currency}";
      // orderP.formatDiscountTotal = "-${format.format(previewDiscountTotal)} ${currency}";

      orderP.formatTotal = "${format.format(previewTotal)}";
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
      toast(message: S.of(context).alltip_loading_error);
      return;
    }

    /// 检查派送地址信息
    if (TextHelper.isEmpty(orderP.name!) ||
        TextHelper.isEmpty(orderP.phone!) ||
        TextHelper.isEmpty(orderP.address!)) {
      toast(message: S.of(context).confirm_address_no);
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
    if (TextHelper.isNotEmpty(deliveryCoastParam)) {
      requestBody.fields.add(MapEntry("delivery_coast", deliveryCoastParam));
    }
    if (TextHelper.isNotEmpty(type)) {
      requestBody.fields.add(MapEntry("type", type));
    }
    if (!isSpecial() && TextHelper.isNotEmpty(promoCode)) {
      requestBody.fields.add(MapEntry("promo_code", promoCode));
    }

    DioClient().post(ShoppingUrl.apiOrder,
        (response) => PreviewOrdersBody.fromJson(response.data),
        body: requestBody, success: (PreviewOrdersBody body) {
      if (body != null && body.data != null) {
        LogDog.d("checkoutPreviewOrder-Response: ${body}");

        /// 订单创建完成
        complete.call();
      } else {
        toast(message: S.of(context).alltip_loading_error);
      }
    }, fail: (message, error) {
      notifyToasty(message);
    });
  }
}
