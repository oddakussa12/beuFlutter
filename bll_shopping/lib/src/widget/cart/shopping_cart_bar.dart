import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping/src/actuator/product_option_provider.dart';
import 'package:shopping/src/actuator/shopping_cart_actuator.dart';
import 'package:shopping/src/widget/cart/item_shopping_cart_product.dart';
import 'package:shopping/src/controller/shopping_cart_controller.dart';
import 'package:shopping/src/widget/shake/shake_controller.dart';
import 'package:shopping/src/widget/shake/shake_type.dart';
import 'package:shopping/src/widget/shake/shake_widget.dart';

/**
 * shopping_cart_bar.dart
 * 购物条【商铺详情 & 商品详情】
 * @author: Ruoyegz
 * @date: 2021/7/4
 */
class ShoppingCartBar extends StatefulWidget {
  final String shopId;
  final bool isShowBar;
  final bool isCartProducts;
  final ShoppingCartBarController controller;

  const ShoppingCartBar(
      {Key? key,
      required this.isShowBar,
      required this.isCartProducts,
      required this.shopId,
      required this.controller})
      : super(key: key);

  @override
  ShoppingCartBarState createState() =>
      ShoppingCartBarState(ShoppingCartActuator());
}

class ShoppingCartBarState
    extends ReactableState<ShoppingCartActuator, ShoppingCartBar>
    with ProductOptionProvider {
  /// 购物车商品列表显示控制
  late bool showProducts = true;

  /// 是否播放动画
  bool isPlayAnimator = false;

  /// 购物车是否发生改变
  bool isShoppingCartChanged = false;

  /// 动画控制器
  ShakeController _animController = ShakeController();

  ShoppingCartBarState(ShoppingCartActuator actuator) : super(actuator);

  @override
  void initState() {
    super.initState();
    widget.controller.initController(this);
    actuator.shopId = widget.shopId;
    actuator.loadMyShopCart();
  }

  @override
  void dispose() {
    if (isShoppingCartChanged && actuator.shopId != null) {
      BusClient().fire(ShoppingCartEvent(actuator.shopId));
    }
    super.dispose();
  }

  void outsideAddProduct(Product product, Shop shop) {
    isShoppingCartChanged = true;
    actuator.outsideAppendProduct(shop, product);
    runningShakeAnimator();
  }

  @override
  void addProduct(Product product, Shop shop) {
    isShoppingCartChanged = true;
    actuator.appendCartProduct(shop, product);
    runningShakeAnimator();
  }

  /**
   * 商铺下的商品数量减减
   */
  @override
  void minusProduct(Product product, Shop shop) {
    super.minusProduct(product, shop);
    isShoppingCartChanged = true;
    actuator.minusCartProduct(context, shop, product);
  }

  void openOrderPreview(BuildContext context, Map<String, String> idNumbers) {
    Navigator.pushNamed(context, Routes.shopping.OrderPreview,
        arguments: idNumbers);
  }

  void runningShakeAnimator() {
    if (_animController.animationRunning) {
      ///停止抖动动画
      _animController.stop();
    } else {
      ///开启抖动动画
      ///参数shakeCount 用来配置抖动次数
      ///通过 controller start 方法默认为 1
      _animController.start(shakeCount: 1);
    }
  }

  void toggle() {
    if (widget.isCartProducts) {
      setState(() {
        showProducts = !showProducts;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isShowBar) {
      return Container();
    }
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        /// 商品列表
      buildShoppingCartProducts(context),

      //   /// 购物车
       buildShoppingCartBar(context),
      ],
    );
  }

  /**
   * 购物车
   */
  Widget buildShoppingCartBar(BuildContext context) {
    /// 外部白色边框
    return Container(
      height: 64,
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 16, bottom: 16, left: 16),
      decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
                color: AppColor.bg,
                offset: Offset(2.0, 2.0),
                blurRadius: 5.0,
                spreadRadius: 0.6),
            BoxShadow(color: AppColor.bg, offset: Offset(1.0, 1.0)),
            BoxShadow(color: AppColor.bg)
          ],
          borderRadius: BorderRadius.circular(40)),

      /// 内部渐变条
      child: Container(
        height: 48,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48),
            gradient: LinearGradient(
                colors: [Color(0xFFFF8913), Color(0xFFFF0080)],
                begin: FractionalOffset(1, 0),
                end: FractionalOffset(0, 1))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            /// 左边购物车及角标
            buildShopCartAndNumber(context),

            /// 购物车总价和派送费
            buildCartTotalPrice(),

            /// 下单按钮
            buildCartBuy(context)
          ],
        ),
      ),
    );
  }

  /**
   * 左边购物车及角标
   */
  Widget buildShopCartAndNumber(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          /// 购物车图标
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 4),
            decoration: BoxDecoration(
                color: AppColor.white, borderRadius: BorderRadius.circular(40)),
            child:
                Image.asset("res/icons/ic_shop_cart.png", package: 'resources'),
            width: 40,
            height: 40,
          ),

          /// 购物车角标
          ShakeWidget(
            controller: _animController,
            //微旋转的抖动
            shakeType: ShakeType.Skew,
            //设置不开启抖动
            isForward: false,
            //默认为 0 无限执行
            shakeCount: 0,
            //抖动的幅度 取值范围为[0,1]
            shakeRange: 0.22,
            child: Container(
              height: 16,
              padding: EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 32, top: 2),
              decoration: BoxDecoration(
                  color: AppColor.black,
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                actuator.shopCart.number! >= 99
                    ? "99+"
                    : "${actuator.shopCart.number}",
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    color: AppColor.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      onTap: () {
        setState(() {
          showProducts = !showProducts;
        });
      },
    );
  }

  /**
   * 购物车总价和派送费
   */
  Widget buildCartTotalPrice() {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// 总价
        GestureDetector(
          child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 8),
            child: Text(
              TextHelper.clean(actuator.shopCart.formatTotal),
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppColor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () {
            setState(() {
              showProducts = !showProducts;
            });
          },
        ),

        /// 派送费
        GestureDetector(
          child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10, top: 4),
              child: Text(
                TextHelper.isEmpty(actuator.shopCart.formatCoast)
                    ? ""
                    : "${actuator.shopCart.formatCoast} ${S.of(context).shopcenter_fee}",
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColor.colorB3FFF,
                  fontSize: 12,
                ),
              )),
          onTap: () {
            setState(() {
              showProducts = !showProducts;
            });
          },
        )
      ],
    ));
  }

  /**
   * 下单按钮
   * "Buy now"
   */
  Widget buildCartBuy(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 32,
        width: 110,
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
            color: AppColor.white, borderRadius: BorderRadius.circular(24)),
        child: Text(S.of(context).shopcenter_buy,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.colorF7551D,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
      ),
      onTap: () {
        actuator.previewOrder(
            (BuildContext context, Map<String, String> idNumbers) {
                
          openOrderPreview(context, idNumbers);
        });
      },
    );
  }

  double getHeight() {
    if (actuator.shopCart.data == null || actuator.shopCart.data.isEmpty) {
      return 0.0;
    }
    double halfHeight = MediaQuery.of(context).size.height / 2 - 32;
    var singleItemHeight = actuator.shopCart.data[0].goods!.length * 80.0;
    double itemHeight = singleItemHeight + 64.0;
    return halfHeight > itemHeight ? itemHeight : halfHeight;
  }

  /**
   * 购物车商品列表
   */
  Widget buildShoppingCartProducts(BuildContext context) {
    return Offstage(
        offstage: showProducts,
        child: Container(
            height: getHeight(),
            padding: EdgeInsets.only(top: 20, bottom: 39),
            margin: EdgeInsets.only(left: 15, right: 15, bottom: 40),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                color: AppColor.white,
                border: Border.all(color: AppColor.colorEF, width: 1),
                boxShadow: [
                  BoxShadow(
                      color: AppColor.bg,
                      offset: Offset(3.0, 3.0),
                      blurRadius: 5.0,
                      spreadRadius: 4),
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4))),

            /// 购物车商品列表
            child: buildProductList()));
  }

  Container buildProductsTitle() {
    return Container(
      height: 48,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 16, right: 16),
      child: Text(
        S.of(context).shopcart_my_bag,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppColor.black, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildProductList() {
    if (actuator.shopCart.data == null || actuator.shopCart.data.isEmpty) {
      return Container();
    }
    return SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: actuator.shopCart.data[0].goods!.length,
            padding: EdgeInsets.only(bottom: 8),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var mainShop = actuator.shopCart.data[0];
              var product = mainShop.goods![index];
              return ItemShoppingCartProductWidget(
                key: Key("${product.id}-${product.name}"),
                shop: mainShop,
                product: product,
                provider: this,
              );
            }));
  }
}
