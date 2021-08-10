import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:shopping/src/controller/shopping_cart_controller.dart';
import 'package:shopping/src/shopping_config.dart';

/**
 * ShopDetailActuator
 * 商铺详情
 * @author: Ruoyegz
 * @date: 2021/7/24
 */
class ShopDetailActuator extends RefreshActuator {
  /// 购物车是否发生改变
  bool isShoppingCartChanged = false;

  /// 刷新详情标志位
  bool isNeedRefreshDetail = true;

  /// 刷新购物车标志位
  bool isNeedRefreshCart = true;

  /// 商铺详情
  Shop shopDetail = Shop("");

  /// 商品列表
  List<Product> products = [];

  @override
  void attachViewer(Viewer view) {
    super.attachViewer(view);

    /// 监听订单创建完成的事件，并刷新数据
    appendSubscribe(BusClient().on<OrderCreatedEvent>().listen((event) {
      if (event != null && context != null) {
        Navigator.pop(context);
      }
    }));
  }

  /**
   * 初始化购物车
   */
  void initShopDetail(Shop args, ShoppingCartBarController bar) {
    /**
     * 购物车更新事件
     * 案例：在商铺详情页操作了购物车后，
     * 点击了某个商品详情页操作了购物车
     */
    appendSubscribe(BusClient().on<ShoppingCartUpdateEvent>().listen((event) {
      if (event != null &&
          shopDetail != null &&
          TextHelper.isEqual(event.shopId, shopDetail.id)) {
        if (bar != null) {
          bar.forceRefresh();
        }
      }
    }));

    if ((args == null && shopDetail == null)) {
      return;
    }

    /// 初始化时，创建当前的商铺详情
    if (args != null) {
      shopDetail = Shop.create(args);
    }
    isNeedRefreshDetail = true;
    pullDown();
  }

  @override
  void dispose() {
    super.dispose();
    products.clear();
  }

  @override
  void toRetry() {
    super.toRetry();
  }

  @override
  void onRefreshSource(int page, PullType type) {
    loadShopDetail();
    loadProducts(page, type);
  }

  @override
  void onLoadMoreSource(int page, PullType type) {
    loadProducts(page, type);
  }

  /**
   * 加载商铺信息
   */
  void loadShopDetail() async {
    /// 已经取到正确的商铺信息了，不需要每次刷新
    if (!isNeedRefreshDetail) {
      return;
    }

    String url =
        ShoppingUrl.getUserInfo + "${shopDetail.id}/?action=view&referrer=";
    DioClient().get(url, (response) => ShopDetail.fromJson(response.data),
        success: (ShopDetail detail) {
      if (detail != null && detail.data != null) {
        shopDetail = detail.data;
        isNeedRefreshDetail = false;

        LogDog.d("loadShopDetail-bg: ${shopDetail.bg}");
      }
    }, fail: (message, error) {
      isNeedRefreshDetail = true;
    });
  }

  /**
   * 加载商铺下的商品列表
   */
  loadProducts(int page, PullType type) async {
    if (products.isEmpty) {
      changeStatusForLoading();
    }

    String url =
        ShoppingUrl.products + "?page=${page}&user_id=${shopDetail.id}";
    DioClient().get(url, (response) => ProductList.fromJson(response.data),
        success: (ProductList body) {
      if (body != null && body.data != null) {
        if (page <= 1) {
          products.clear();
        }

        products.addAll(body.data);
      }
    }, complete: () {
      emptyStatus =
          products.isNotEmpty ? EmptyStatus.Normal : EmptyStatus.Empty;
      refreshCompleted(type);
      notifySetState();
    });
  }

  /// 关注店铺
  void followShop({Actioned? start, Complete? complete}) async {
    if (start != null) {
      start.call();
    }

    DioClient().post(ShoppingUrl.followShop, (response) => (response),
        body: {"followed_id": "${shopDetail.id}"}, success: (Response body) {
      if (body != null && body.statusCode! >= 200 && body.statusCode! < 300) {
        toast(message: S.of(context).shopcenter_followed);
        notifySetState(() {
          shopDetail.followState = true;
        });
      }
    }, fail: (message, error) {
      notifyToasty(message);
    }, complete: complete);
  }
}
