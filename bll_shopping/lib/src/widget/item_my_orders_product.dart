
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

/**
 * item_my_bag_product.dart
 * 购物车商品下商品项
 * @author: Ruoyegz
 * @date: 2021/7/2
 */
class ItemMyOrdersProductWidget extends StatefulWidget {
  final Shop shop;

  /// 商铺信息
  final Product product;

  const ItemMyOrdersProductWidget({
    Key? key,
    required this.shop,
    required this.product,
  }) : super(key: key);

  @override
  _ItemMyOrdersProductState createState() =>
      _ItemMyOrdersProductState(shop, product);
}

class _ItemMyOrdersProductState extends State<ItemMyOrdersProductWidget> {
  final Shop shop;
  final Product product;

  _ItemMyOrdersProductState(this.shop, this.product);

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return Container();
    }
    if (product.isChecked == null) {
      product.isChecked = false;
    }
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 4, right: 4, top: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /// 购物车商品图片
          buildCartProductImage(),

          /// 购物车商品信息
          buildCartProductInfo(),

          /// 购物车商品数量
          buildProductNumber()
        ],
      ),
    );
  }

  /**
   * 购物车商品图片
   */
  Widget buildCartProductImage() {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: FadeInImage.assetNetwork(
          height: 64,
          width: 64,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 100),
          placeholder: "packages/resources/res/images/def_cover_1_1.png",
          image: product.productImage(),
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset("res/images/def_cover_1_1.png", package: 'resources',);
          },
        ),
      ),
    );
  }

  /**
   * 购物车商品信息
   */
  Widget buildCartProductInfo() {
    return Expanded(
        child: Container(
      height: 60,
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 2),
              alignment: Alignment.topLeft,
              child: Text(
                TextHelper.clean(product.name),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: AppColor.color0F0F17, fontSize: 14),
              )),
          Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              alignment: Alignment.topLeft,
              child: Text(
                TextHelper.clean(product.formatPrice),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: AppColor.colorBE, fontSize: 16),
              ))
        ],
      ),
    ));
  }

  Widget buildProductNumber() {
    return Container(
        height: 24,
        width: 30,
        alignment: Alignment.center,
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.only(left: 1, right: 1),
        child: Text(
          "${product.goodsNumber}",
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColor.black, fontSize: 14, fontWeight: FontWeight.bold),
        ));
  }
}
