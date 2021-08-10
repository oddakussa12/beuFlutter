import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shopping/src/actuator/product_option_provider.dart';
import 'package:shopping/src/actuator/shopping_my_bag_actuator.dart';
import 'package:shopping/src/items/item_my_bag_shop.dart';

/**
 * my_bag_page.dart
 * 我的购物车
 * @author: Ruoyegz
 * @date: 2021/6/29
 */
class ShoppingMyBagPage extends StatefulWidget {
  const ShoppingMyBagPage({Key? key}) : super(key: key);

  @override
  State<ShoppingMyBagPage> createState() =>
      _ShoppingMyBagState(ShoppingMyBagActuator());
}

class _ShoppingMyBagState
    extends RefreshableState<ShoppingMyBagActuator, ShoppingMyBagPage>
    with AutomaticKeepAliveClientMixin, ProductOptionProvider {
  _ShoppingMyBagState(actuator) : super(actuator);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    actuator.pullDown();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  bool isCheckedOfProduct(String id) {
    return actuator.isCheckByProductId(id);
  }

  @override
  void checkShopProduct(Shop shop, Product product) {
    super.checkShopProduct(shop, product);
    actuator.selectShopProduct(shop, product);
  }

  @override
  void addProduct(Product product, Shop shop) {
    super.addProduct(product, shop);
    actuator.appendCartProduct(shop, product);
  }

  /// 商铺下的商品数量减减
  @override
  void minusProduct(Product product, Shop shop) {
    super.minusProduct(product, shop);
    actuator.minusCartProduct(shop, product);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    LogDog.w("ShoppingMyBagPage, build");

    return Scaffold(
      appBar: ToolbarOnlyTitle(
        title: S.of(context).shopcart_shopping,
      ),
      body: SmartRefresher(
          physics: BouncingScrollPhysics(),
          controller: refreshController,
          header: WaterDropHeader(),
          enablePullDown: true,
          enablePullUp: false,
          onRefresh: () {
            actuator.pullDown();
          },

          /// 购物车商品列表
          child: actuator.isNotNormal()
              ? buildEmptyWidget(context)
              : buildCartProducts()),
      bottomNavigationBar: buildCartMeter(),
    );
  }

  /**
   * 购物车商品列表
   */
  Widget buildCartProducts() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 16, bottom: 10),
      itemCount: actuator.shopCart.data.length,
      itemBuilder: (context, index) {
        var shop = actuator.shopCart.data[index];
        return ItemMyBagShopWidget(
          key: Key("${shop.id}-${shop.name}"),
          shop: shop,
          provider: this,
        );
      },
    );
  }

  /**
   * 购物车计价条
   */
  Widget buildCartMeter() {
    if (actuator.isNoneShoppingCart()) {
      return Container(
        height: 1,
      );
    }
    return Container(
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
              color: AppColor.bg,
              offset: Offset(8.0, 1.0),
              blurRadius: 5.0,
              spreadRadius: 0.6),
          BoxShadow(color: AppColor.bg, offset: Offset(1.0, 1.0)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// 已选商品价格
          buildCartTotalPrice(),

          /// 下单按钮
          buildCartBuy(),
        ],
      ),
    );
  }

  /**
   * 已选商品价格
   */
  Expanded buildCartTotalPrice() {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(left: 20, right: 10),
      child: Text(
        TextHelper.clean(actuator.shopCart.formatTotal),
        maxLines: 1,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: AppColor.colorF7551D,
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
    ));
  }

  /**
   * 下单按钮
   */
  Widget buildCartBuy() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
          height: 44,
          width: 140,
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(44),
              gradient: LinearGradient(
                  colors: [Color(0xFFFF8913), Color(0xFFFF0080)],
                  begin: FractionalOffset(1, 0),
                  end: FractionalOffset(0, 1))),
          child: Text(
            S.of(context).shopcart_buy,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: TextStyle(
                color: AppColor.white,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          )),
      onTap: () {
        actuator.previewOrder((context, Map<String, String> idNumbers) {
          Navigator.pushNamed(context, Routes.shopping.OrderPreview,
              arguments: idNumbers);
        });
      },
    );
  }
}
