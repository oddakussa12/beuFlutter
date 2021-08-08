import 'package:common/common.dart';
import 'package:dio/dio.dart';
import 'package:shopping/src/actuator/shopping_cart_actuator.dart';
import 'package:shopping/src/shopping_config.dart';

/**
 * ShoppingMyBagActuator
 * 购物车 My bag 操作
 * @author: Ruoyegz
 * @date: 2021/7/27
 */
class ShoppingMyBagActuator extends RefreshActuator {
  /// 已选中的商铺列表
  List<Shop> selectedShops = [];

  /// 已选中的商品列表【id : isChecked】
  Map<String, bool> selectedProducts = {};

  /// 初始化购物车
  final ShoppingCart shopCart = ShoppingCart.create();

  @override
  void attachViewer(Viewer view) {
    super.attachViewer(view);

    /// 事件总线监听购物车变化
    appendSubscribe(
        BusClient().subscribe<ShoppingCartEvent>((event) => loadMyShopCart()));

    /// 监听订单创建完成的事件，并刷新数据
    appendSubscribe(BusClient().subscribe<OrderCreatedEvent>((event) {
      if (event != null) {
        clearSelected();
        loadMyShopCart();
      }
    }));

    appendSubscribe(BusClient()
        .subscribe<ShoppingCartUpdateEvent>((event) => loadMyShopCart()));

    /// 登录事件
    appendSubscribe(
        BusClient().subscribe<SignInEvent>((event) => loadMyShopCart()));

    /// 退出登录事件
    appendSubscribe(BusClient().subscribe<LogoutEvent>((event) {
      if (event != null) {
        cleanShoppingCartByLogout();
      }
    }));

    /// 事件总线监听购物车变化
    appendSubscribe(
        BusClient().subscribe<ShoppingCartEvent>((event) => loadMyShopCart()));

    appendSubscribe(BusClient()
        .subscribe<ShoppingCartUpdateEvent>((event) => loadMyShopCart()));

    /// 监听订单创建完成的事件，并刷新数据
    appendSubscribe(BusClient()
        .subscribe<ShoppingCartUpdateEvent>((event) => loadMyShopCart()));

    /// 退出登录事件
    appendSubscribe(BusClient()
        .subscribe<ShoppingCartUpdateEvent>((event) => loadMyShopCart()));
  }

  @override
  void dispose() {
    super.dispose();
    selectedShops.clear();
    selectedProducts.clear();
  }

  @override
  void toRetry() {
    super.toRetry();
    loadMyShopCart();
  }

  @override
  void onRefreshSource(int page, PullType type) {
    loadMyShopCart();
  }

  @override
  void onLoadMoreSource(int page, PullType type) {}

  bool isNoneShoppingCart() {
    return shopCart.data == null || shopCart.data.isEmpty;
  }

  //// 退出登录后清理购物车
  void cleanShoppingCartByLogout() {
    selectedShops.clear();
    selectedProducts.clear();
    if (shopCart != null && shopCart.data != null) {
      shopCart.data.clear();
    }
    _processShoppingCartInfo();
  }

  void clearSelected() {
    selectedShops.clear();
    selectedProducts.clear();

    _processShoppingCartInfo();
  }

  /**
   * 选择商商铺中商品到预览订单
   */
  void selectShopProduct(Shop shop, Product product) async {
    if (shop != null && product != null) {
      /// 将选中的商品缓存起来，避免每次刷新后状态丢失
      product.isChecked = product.isChecked == null ? false : product.isChecked;
      if (product.isChecked!) {
        selectedProducts[product.id] = true;
      } else {
        selectedProducts.remove(product.id);
      }

      /// 更新购物车信息
      _processShoppingCartInfo();
    }
  }

  /**
   * 加载我的购物车
   */
  loadMyShopCart() async {
    if (isNoneShoppingCart()) {
      changeStatusForLoading();
    }

    DioClient().get(ShoppingUrl.optionCart,
        (response) => ShoppingCart.fromJson(response.data),
        success: (ShoppingCart body) {
      if (body != null) {
        shopCart.data = body.data;
      }
    }, fail: (message, error) {
      LogDog.w("loadMyShopCart, error: ${message}");
    }, complete: () {
      refreshCompleted(PullType.Both);

      /// 计算购物车金额
      _processShoppingCartInfo();
    });
  }

  bool isCheckByProductId(String id) {
    if (id != null && selectedProducts.isNotEmpty) {
      var isChecked = selectedProducts[id];
      return isChecked == null ? false : isChecked;
    }
    return false;
  }

  /**
   * 增加购物车中商品的数量
   */
  void appendCartProduct(Shop shop, Product product) {
    if (product.goodsNumber == null) {
      product.goodsNumber = 1;
    } else {
      if (product.goodsNumber! >= 50) {
        toast(message: S.of(context).shopcart_product_rule);
        return;
      }

      product.goodsNumber = product.goodsNumber! + 1;
    }
    _updateShoppingCart(true, shop, product);
  }

  /**
   * 减少购物车中商品的数量
   */
  void minusCartProduct(Shop shop, Product product) {
    if (product.goodsNumber == null || product.goodsNumber! <= 1) {
      product.goodsNumber = 0;
    } else {
      product.goodsNumber = product.goodsNumber! - 1;
    }
    _updateShoppingCart(false, shop, product);
  }

  /**
   * 更新购物车
   */
  void _updateShoppingCart(bool isAppend, Shop shop, Product product) async {
    FormData requestBody = FormData.fromMap({
      "goods_id": "${product.id}",
      "user_id": "${shop.id}",
      "number": product.goodsNumber,
      "type": "update"
    });

    bool needSetState = true;
    DioClient().post(ShoppingUrl.optionCart,
        (response) => ShoppingCart.fromJson(response.data), body: requestBody,
        success: (ShoppingCart body) {
      if (body != null) {
        /// 处理购物车
        processCartUpdateSuccessResult(body, shop, product);
        needSetState = false;
      } else {
        processCartUpdateFailureResult(isAppend, shop, product);
      }
    }, fail: (message, error) {
      processCartUpdateFailureResult(isAppend, shop, product);
      notifyToasty(message);
    }, complete: () {
      notifySetState();
    });
  }

  /**
   * 处理购物车更新成功的结果
   */
  void processCartUpdateSuccessResult(
      ShoppingCart result, Shop shop, Product product) {
    /// 当前操作的商品的购物车已被清空
    if (result.data == null || result.data.isEmpty) {
      /// 将当前的商品从本地购物车中移除
      if (shopCart.data != null && shopCart.data.contains(shop)) {
        shopCart.data.remove(shop);
      }
    } else {
      /// 网络更新购物车成功后，如果本地的商品数量为 0，则移除该商品
      if (product.goodsNumber! <= 0) {
        if (shop.goods != null && shop.goods!.contains(product)) {
          shop.goods!.remove(product);
        }

        /// 如果当前商铺购物车已经为空，则移除
        if (shop.goods == null || shop.goods!.isEmpty) {
          if (shopCart.data != null) {
            shopCart.data.remove(shop);
          }
        }
      }
    }

    /// 计算购物车金额
    _processShoppingCartInfo();
  }

  /**
   * 加减购物车请求失败后要回滚 goodsNumber
   * 当goodsNumber 达到上限时会出 bug
   */
  void processCartUpdateFailureResult(
      bool isAppend, Shop shop, Product localP) {
    if (localP != null) {
      if (isAppend) {
        localP.goodsNumber = localP.goodsNumber! - 1;
      } else {
        localP.goodsNumber = localP.goodsNumber! + 1;
      }
    }

    toast(message: S.of(context).alltip_loading_error);
  }

  /**
   * 计算购物车金额
   */
  void _processShoppingCartInfo() async {
    if (shopCart.data == null || shopCart.data.isEmpty) {
      shopCart.formatTotal = "";
      shopCart.currency = "";
    } else {
      double total = 0;
      String currency = "";
      shopCart.isDiffCurrency = false;
      shopCart.data.forEach((shop) {
        if (shop.goods != null) {
          /// 遍历当前商铺下的商品
          shop.goods!.forEach((product) {
            product.isChecked = isCheckByProductId(product.id);
            if (product.isChecked!) {
              currency = currency == "" ? shop.currency! : currency;
              total += product.price! * product.goodsNumber!;

              /// 不同的币种【对每个商品都需要检查】
              if (currency != "" &&
                  !TextHelper.isEqual(currency, shop.currency!)) {
                shopCart.isDiffCurrency = true;
              } else {
                /// 相同币种下，派送费用累加
                // coast += shop.coast!;
              }
            }
          });
        }
      });
      if (shopCart.isDiffCurrency!) {
        shopCart.formatTotal = "--";
      } else {
        shopCart.total = total;
        shopCart.currency = currency;
        if (total <= 0) {
          shopCart.formatTotal = "";
        } else {
          shopCart.formatTotal = "${total} ${currency}";
        }
      }
    }
    if (isNoneShoppingCart()) {
      emptyStatus = EmptyStatus.Empty;
    } else {
      emptyStatus = EmptyStatus.Normal;
    }

    notifySetState();
  }

  void previewOrder(OrderPreviewCallback callback) async {
    /// 购物车为空
    if (shopCart == null || shopCart.data == null || shopCart.data.isEmpty) {
      // "请选择商品"
      notifyToasty(S.of(context).shopcart_choose_product);
      return;
    }

    Map<String, String> idNumbers = {};
    shopCart.data.forEach((shop) {
      if (shop.goods != null) {
        shop.goods!.forEach((product) {
          if (product.alreadyChecked()) {
            idNumbers["${product.id}"] = "${product.goodsNumber}";
          }
        });
      }
    });
    if (idNumbers.isEmpty) {
      // "请选择商品"
      notifyToasty(S.of(context).shopcart_choose_product);
      return;
    }

    callback.call(context, idNumbers);
  }
}
