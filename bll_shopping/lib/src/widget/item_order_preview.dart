import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping/src/actuator/product_option_provider.dart';

import 'item_order_preview_product.dart';

/**
 * ItemOrderPreviewWidget
 * 订单预览列表项
 * @author: Ruoyegz
 * @date: 2021/7/2
 */
class ItemOrderPreviewWidget extends StatefulWidget {
  final Shop shop;

  /// 订单序号
  final int orderNumber;
  final PreOrder orderItem;
  final ProductOptionProvider provider;

  const ItemOrderPreviewWidget(
      {Key? key,
      required this.orderNumber,
      required this.shop,
      required this.orderItem,
      required this.provider})
      : super(key: key);

  @override
  _ItemOrderPreviewState createState() =>
      _ItemOrderPreviewState(orderNumber, shop, orderItem, provider);
}

class _ItemOrderPreviewState extends State<ItemOrderPreviewWidget> {
  final Shop shop;

  /// 订单序号
  final int orderNumber;
  final PreOrder orderItem;
  final ProductOptionProvider provider;

  _ItemOrderPreviewState(
      this.orderNumber, this.shop, this.orderItem, this.provider);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  /**
   * 打开商铺详情
   */
  void clickOpenShopDetail(BuildContext context) {
    Navigator.pushNamed(context, Routes.shopping.ShopDetail, arguments: orderItem.shop);
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
        "${S.of(context).order_how_many(orderNumber)}",
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

          /// 商品包装费
          buildPackagingFee(),

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
            ))
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
        itemCount: orderItem.goods!.isEmpty ? 0 : orderItem.goods!.length,
        itemBuilder: (context, index) {
          var product = orderItem.goods![index];
          return ItemOrderPreviewProductWidget(
            key: Key("${shop.id}-${product.id}-${DateTime.now().microsecond}"),
            shop: shop,
            product: product,
            provider: provider,
          );
        });
  }

  /**
   * 订单价格信息
   */
  Container buildOrderInfo() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Text(
        S.of(context).order_info,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: AppColor.black, fontSize: 16, fontWeight: FontWeight.bold),
      ),
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
            TextHelper.clean(orderItem.formatSubTotal),
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
  Widget buildOrderCoast() {
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
            TextHelper.clean(orderItem.formatCoast),
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

  /// 商品包装费
  Widget buildPackagingFee() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 10, right: 10, top: 16),
      child: Row(
        children: [
          Text(
            "Packaging fee",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColor.colorBE,
              fontSize: 14,
            ),
          ),
          Expanded(
              child: Text(
                TextHelper.clean(orderItem.formatPackageFee),
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
            TextHelper.clean(orderItem.formatTotal),
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
