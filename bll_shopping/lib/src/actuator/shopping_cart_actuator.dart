import 'package:common/common.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping/src/shopping_config.dart';

typedef OrderPreviewCallback = void Function(
    BuildContext context, Map<String, String> idNumbers);

/**
 * ShoppingCartActuator
 *
 * @author: Ruoyegz
 * @date: 2021/7/24
 */
class ShoppingCartActuator extends ReactActuator {
  /// 商铺 Id
  String shopId = "";

  /// 刷新购物车标志位
  bool isNeedRefreshCart = true;

  /// 购物车中商品和的索引，添加|减少商品数量时使用【id：product】
  Map<String, Product> cartProducts = {};

  /// 购物车
  late ShoppingCart shopCart = new ShoppingCart([],
      formatTotal: "", currency: "", number: 0, formatCoast: "");

  @override
  void dispose() {
    super.dispose();
    cartProducts.clear();
  }

  /**
   * 加载我的购物车【当前店铺】
   */
  void loadMyShopCart() async {
    String url = ShoppingUrl.optionCart + "?user_id=${shopId}";
    DioClient().get(url, (response) => ShoppingCart.fromJson(response.data),
        success: (ShoppingCart body) {
      if (body != null) {
        shopCart.data = body.data;
        isNeedRefreshCart = false;

        /// 处理购物车
        processShoppingCart(shopCart);
      }
    }, fail: (message, error) {
      isNeedRefreshCart = true;
    }, complete: () {
      notifySetState();
    });
  }

  /**
   * 处理购物车内容
   */
  void processShoppingCart(ShoppingCart cart, {Product? target}) async {
    if (cart == null || cart.data == null || cart.data.isEmpty) {
      if (cart == null) {
        cart = new ShoppingCart([],
            formatTotal: "", currency: "", number: 0, formatCoast: "");
      } else {
        cart.number = 0;
        cart.total = 0.0;
        cart.coast = 0.0;
        cart.formatTotal = "";
        cart.formatCoast = "";
      }
    } else {
      double total = 0;
      double coast = 0;
      int productNumber = 0;
      String currency = "";

      cart.data.forEach((shop) {
        if (shop.goods != null) {
          currency = currency == "" ? shop.currency! : currency;
          shop.goods!.forEach((product) {
            cartProducts[product.id] = product;
            product.disPrice =
                ValueFormat.cleanDouble(product.disPrice, def: -1);

            /// 折扣计算
            ///

            if (product.disPrice != -1) {
              total += product.disPrice! * product.goodsNumber!;
            } else {
              total += product.price! * product.goodsNumber!;
            }

            productNumber += product.goodsNumber!;
            if (target != null && target.id == product.id) {
              target.goodsNumber = product.goodsNumber;
            }
          });

          /// 不同的币种
          if (currency != "" && !TextHelper.isEqual(currency, shop.currency!)) {
            cart.isDiffCurrency = true;
          } else {
            /// 相同币种下，派送费用累加
            coast += shop.coast!;
          }
        }
      });

      cart.number = productNumber;
      cart.currency = currency;
      cart.total = total;
      cart.formatTotal = "${total} ${currency}";

      cart.coast = coast;
      cart.formatCoast = "+ ${coast} ${currency}";
    }
    notifySetState();
  }

  /**
   * 提供给外部使用
   */
  void outsideAppendProduct(Shop shop, Product product) {
    /// 商品数量以购物车为主，避免出现置零 bug

    var cartP = cartProducts[product.id];
    if (cartP != null) {
      if (cartP.goodsNumber! >= 50) {
        toast(message: S.of(context).shopcart_product_rule);
        return;
      }

      cartP.goodsNumber = cartP.goodsNumber! + 1;
      product.goodsNumber = cartP.goodsNumber;
    } else {
      if (product.goodsNumber == null) {
        product.goodsNumber = 1;
      }
      cartProducts[product.id] = product;
    }

    _updateShoppingCart(true, shop, product);
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
  void minusCartProduct(BuildContext context, Shop shop, Product product) {
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

    DioClient().post(ShoppingUrl.optionCart,
        (response) => ShoppingCart.fromJson(response.data), body: requestBody,
        success: (ShoppingCart body) {
      if (body != null) {
        /// 处理购物车

        processCartUpdateSuccessResult(body, shop, product);
        //  print(product.disPrice);
        LogDog.d("appendProduct: ${shopCart}");
      } else {
        processCartUpdateFailureResult(context, isAppend, shop, product);
      }
    }, fail: (message, error) {
      processCartUpdateFailureResult(context, isAppend, shop, product);
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

      /// 检查购物车
      /// 外部首次添加时，购物车为空，先初始化购物车
      if (isDiffCart(shopCart, result)) {
        shopCart.data = result.data;
      }
    }

    /// 计算购物车金额
    processShoppingCart(shopCart, target: product);
  }

  bool isDiffCart(ShoppingCart oldCart, ShoppingCart newCart) {
    if (oldCart.data == null || oldCart.data.isEmpty) {
      return true;
    } else if (oldCart.data.length != newCart.data.length) {
      return true;
    } else if (oldCart.data.length == newCart.data.length &&
        oldCart.data.length == 1) {
      Shop shop1 = oldCart.data[0];
      Shop shop2 = newCart.data[0];
      if (shop1.goods != null &&
          shop2.goods != null &&
          shop1.goods!.length != shop2.goods!.length) {
        return true;
      }
    }
    return false;
  }

  /**
   * 加减购物车请求失败后要回滚 goodsNumber
   * 当goodsNumber 达到上限时会出 bug
   */
  void processCartUpdateFailureResult(
      BuildContext context, bool isAppend, Shop shop, Product localP) {
    if (localP != null) {
      if (isAppend) {
        localP.goodsNumber = localP.goodsNumber! - 1;
      } else {
        localP.goodsNumber = localP.goodsNumber! + 1;
      }
    }

    notifySetState();
  }

  void previewOrder(OrderPreviewCallback callback) async {
    /// 购物车为空
    if (shopCart == null || shopCart.data == null || shopCart.data.isEmpty) {
      notifyToasty(S.of(context).shopcart_choose_product);
      return;
    }

    Map<String, String> idNumbers = {};
    shopCart.data.forEach((shop) {
      if (shop.goods != null) {
        shop.goods!.forEach((product) {
          idNumbers["${product.id}"] = "${product.goodsNumber}";
        });
      }
    });
    if (idNumbers.isEmpty) {
      notifyToasty(S.of(context).shopcart_choose_product);
      return;
    }

    LogDog.d("openOrderPreview: ${idNumbers}");

    if (callback != null) {
      callback.call(context, idNumbers);
    }
  }
}
