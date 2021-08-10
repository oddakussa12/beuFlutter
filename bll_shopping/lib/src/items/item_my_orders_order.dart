import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/**
 * ItemOrderPreviewWidget
 * 订单预览列表项
 * @author: Ruoyegz
 * @date: 2021/7/2
 */
class ItemMyOrdersOrderWidget extends StatefulWidget {
  final Shop shop;

  /// 订单序号
  final int orderNumber;
  final Order order;

  const ItemMyOrdersOrderWidget({
    Key? key,
    required this.orderNumber,
    required this.shop,
    required this.order,
  }) : super(key: key);

  @override
  _ItemMyOrdersOrderState createState() =>
      _ItemMyOrdersOrderState(orderNumber, shop, order);
}

class _ItemMyOrdersOrderState extends State<ItemMyOrdersOrderWidget> {
  final Shop shop;

  /// 订单序号
  final int orderNumber;
  final Order order;

  _ItemMyOrdersOrderState(this.orderNumber, this.shop, this.order);

  /**
   * 打开商铺详情
   */
  void clickOpenShopDetail(BuildContext context, Shop target) {
    Navigator.pushNamed(context, Routes.shopping.ShopDetail, arguments: target);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 10),
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
        ],
      ),
    );
  }

  /**
   * 商铺图标及标题
   */
  Container buildShopTitle(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 4),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Row(
          children: [
            Image.asset(
              "res/icons/ic_market_place.png",
              package: 'resources',
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
            clickOpenShopDetail(context, shop);
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
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: ItemCommonProductBar(
                key: Key(
                    "${shop.id}-${product.id}-${DateTime.now().microsecond}"),
                shop: shop,
                product: product,
              ),
              onTap: () {
                /// 打开订单详情
                Navigator.pushNamed(context, Routes.shopping.OrderDetail,
                    arguments: order.id);
              });
        });
  }
}
