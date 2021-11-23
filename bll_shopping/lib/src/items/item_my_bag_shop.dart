import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:shopping/src/actuator/product_option_provider.dart';
import 'package:shopping/src/items/item_my_bag_product.dart';

/**
 * item_my_bag_shop.dart
 * 购物车列表项
 * @author: Ruoyegz
 * @date: 2021/7/2
 */
class ItemMyBagShopWidget extends StatefulWidget {
  final Shop shop;
  final ProductOptionProvider provider;

  const ItemMyBagShopWidget(
      {Key? key, required this.shop, required this.provider})
      : super(key: key);

  @override
  _ItemMyBagShopState createState() => _ItemMyBagShopState();
}

class _ItemMyBagShopState extends State<ItemMyBagShopWidget> {
  /**
   * 打开商铺详情
   */
  void clickOpenShopDetail(BuildContext context, Shop target) {
    Navigator.pushNamed(context, Routes.shopping.ShopDetail, arguments: target);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
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
      margin: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 4),
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
            clickOpenShopDetail(context, widget.shop);
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
        itemCount: widget.shop.goods!.isEmpty ? 0 : widget.shop.goods!.length,
        itemBuilder: (context, index) {
          var product = widget.shop.goods![index];
          return ItemMyBagProductWidget(
            key: Key("${widget.shop.id}-${product.id}"),
            shop: widget.shop,
            product: product,
            provider: widget.provider,
          );
        });
  }
}
