import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:shopping/shopping.dart';

/**
 * ProductDetailActuator
 * 商品详情
 * @author: Ruoyegz
 * @date: 2021/7/27
 */
class ProductDetailActuator extends RetryActuator {
  /// 商铺 Id
  String productId = "";

  /// 商品详情
  Product product = Product.create();

  bool isNeedRefreshDetail = false;

  @override
  void attachViewer(Viewer view) {
    super.attachViewer(view);

    /// 监听订单创建完成的事件，并刷新数据
    appendSubscribe(BusClient().subscribe<OrderCreatedEvent>((event) {
      if (event != null) {
        Navigator.pop(context);
      }
    }));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void toRetry() {}

  /**
   * 加载商铺信息
   */
  void loadProductDetail() async {
    String url =
        ShoppingUrl.productDetail + "${productId}/?action=view&referrer=";
    DioClient()
        .get(url, (response) => ProductDetailBody.fromJson(response.data),
            success: (ProductDetailBody detail) {
      if (detail != null && detail.data != null) {
        product = detail.data;
       

        LogDog.d("loadShopDetail-bg: ${detail}");
      } else {
        isNeedRefreshDetail = true;
      }
    }, fail: (message, error) {
      isNeedRefreshDetail = true;
    }, complete: () {
      notifySetState();
    });
  }
}
