import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping/src/actuator/product_option_provider.dart';

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
  _ItemOrderPreviewState createState() => _ItemOrderPreviewState();
}

class _ItemOrderPreviewState extends State<ItemOrderPreviewWidget> {
  /**
   * 打开商铺详情
   */
  void clickOpenShopDetail(BuildContext context) {
    Navigator.pushNamed(context, Routes.shopping.ShopDetail,
        arguments: widget.orderItem.shop);
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
        "${S.of(context).order_how_many(widget.orderNumber)}",
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
          buildOrderDeliveryCoast(),

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
                TextHelper.clean(widget.shop.nickName),
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
          if (widget.shop != null) {
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
    if (widget.shop.isChecked == null) {
      widget.shop.isChecked = false;
    }
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.orderItem.goods!.isEmpty
            ? 0
            : widget.orderItem.goods!.length,
        itemBuilder: (context, index) {
          var product = widget.orderItem.goods![index];
          return ItemCommonProductBar(
            key: Key("${widget.shop.id}-${product.id}"),
            shop: widget.shop,
            product: product,
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
        S.of(context).order_information,
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
      margin: EdgeInsets.only(left: 10, right: 10, top: 12),
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
            widget.orderItem.subDisTotal != 0
                ? TextHelper.clean(widget.orderItem.formatSubDisTotal)
                : TextHelper.clean(widget.orderItem.formatSubTotal),
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
  Widget buildOrderDeliveryCoast() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 10, right: 10, top: 12),
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
            TextHelper.clean(widget.orderItem.formatDeliveryCoast),
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
      margin: EdgeInsets.only(left: 10, right: 10, top: 12),
      child: Row(
        children: [
          Text(
            S.of(context).changeproduct_packagefee,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColor.colorBE,
              fontSize: 14,
            ),
          ),
          Expanded(
              child: Text(
            TextHelper.clean(widget.orderItem.formatPackageFee),
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
      margin: EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
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
            TextHelper.clean(widget.orderItem.formatTotal),
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
