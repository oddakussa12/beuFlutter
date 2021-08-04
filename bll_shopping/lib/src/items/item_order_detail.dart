
import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping/src/items/item_order_detail_product.dart';

/**
 * ItemOrderDetailWidget
 * 订单详情项
 * @author: Ruoyegz
 * @date: 2021/7/2
 */
class ItemOrderDetailWidget extends StatefulWidget {
  final Shop shop;

  final Order order;

  const ItemOrderDetailWidget(
      {Key? key, required this.shop, required this.order})
      : super(key: key);

  @override
  _ItemOrderDetailState createState() => _ItemOrderDetailState(shop, order);
}

class _ItemOrderDetailState extends State<ItemOrderDetailWidget> {
  final Shop shop;

  final Order order;

  _ItemOrderDetailState(this.shop, this.order);

  @override
  void initState() {
    super.initState();
  }

  /**
   * 打开商铺详情
   */
  void clickOpenShopDetail(BuildContext context) {
    Navigator.pushNamed(context, Routes.shopping.ShopDetail, arguments: shop);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        /// 订单序号
        buildOrderNumber(),

        /// 订单商品信息
        buildOrderProductInfo(context),
      ],
    );
  }

  /**
   * 订单序号
   */
  Container buildOrderNumber() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 6),
      child: Text(
        S.of(context).shopcart_my_bag,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: AppColor.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  /**
   * 订单商品信息
   */
  Container buildOrderProductInfo(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      padding: EdgeInsets.only(bottom: 6),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: AppColor.color08000, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          /// 商铺图标及标题
          buildShopTitle(context),

          /// 购物车中商品列表
          buildShopProducts(),

          /// 订单价格信息
          buildOrderInfo(),

          /// 订单价格【Subtotal】
          buildOrderSubTotalPrice(),

          /// 订单派送费
          buildOrderCoast(),

          /// 订单总价
          buildOrderTotalPrice()
        ],
      ),
    );
  }

  /**
   * 商铺图标及标题
   */
  Container buildShopTitle(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 16, bottom: 4),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Row(
          children: [
            Image.asset(
              "res/icons/ic_market_place.png",
              package: "resources",
              width: 24,
              height: 24,
            ),

            /// 商铺标题
            Expanded(
                child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 8),
              child: Text(
                TextHelper.clean(shop.name),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: AppColor.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            )),

            /// 订单进度
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 4),
              child: Text(
                order.status == 0
                    ? S.of(context).shopcart_progress
                    : order.status == 1
                        ? S.of(context).shopcart_completed
                        : S.of(context).shopcart_canceled,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  /// 已取消时显示下划线
                  decoration: order.status == 2
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,

                  /// 0:进行中,1:已完成;2:已取消
                  color: order.status == 0
                      ? AppColor.colorF7551D
                      : order.status == 1
                          ? AppColor.color14B82F
                          : AppColor.colorBE,
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
        onTap: () {
          if (shop != null) {
            /// 打开商铺详情
            clickOpenShopDetail(context);
          }
        },
      ),
    );
  }

  /**
   * 购物车中商品列表
   */
  ListView buildShopProducts() {
    if (shop.isChecked == null) {
      shop.isChecked = false;
    }
    return ListView.builder(

        /// 禁用滑动事件
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: order.goods!.isEmpty ? 0 : order.goods!.length,
        itemBuilder: (context, index) {
          var product = order.goods![index];
          return ItemOrderDetailProductWidget(
            key: Key("${shop.id}-${product.id}-${DateTime.now().microsecond}"),
            shop: shop,
            product: product,
          );
        });
  }

  /**
   * 订单价格信息
   */
  Widget buildOrderInfo() {
    return Row(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Text(
            S.of(context).order_number,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: AppColor.black,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),

        /// Order number
        Expanded(
            child: Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(left: 16, right: 10, top: 20),
          child: Text(
            TextHelper.clean(order.id),
            maxLines: 1,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: AppColor.colorF7551D,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        )),
      ],
    );
  }

  /**
   * 订单价格【Subtotal】
   */
  Container buildOrderSubTotalPrice() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 10, right: 10, top: 16),
      child: Row(
        children: [
          Text(
            S.of(context).order_subtotal,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColor.colorBE,
              fontSize: 14,
            ),
          ),
          Expanded(
              child: Text(
            TextHelper.clean(order.formatPrice),
            maxLines: 1,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColor.black,
              fontSize: 14,
            ),
          ))
        ],
      ),
    );
  }

  /**
   * 订单派送费
   */
  Container buildOrderCoast() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 10, right: 10, top: 16),
      child: Row(
        children: [
          Text(
            S.of(context).order_delivery_coast,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColor.colorBE,
              fontSize: 14,
            ),
          ),
          Expanded(
              child: Text(
            TextHelper.clean(order.formatCoast),
            maxLines: 1,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColor.black,
              fontSize: 14,
            ),
          ))
        ],
      ),
    );
  }

  /**
   * 订单总价
   */
  Container buildOrderTotalPrice() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 10, right: 10, top: 16, bottom: 16),
      child: Row(
        children: [
          Text(
            S.of(context).order_total,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColor.colorBE,
              fontSize: 14,
            ),
          ),
          Expanded(
              child: Text(
            TextHelper.clean(order.formatTotal),
            maxLines: 1,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: AppColor.black,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ))
        ],
      ),
    );
  }
}
