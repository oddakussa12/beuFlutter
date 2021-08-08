
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shopping/src/actuator/product_option_provider.dart';

/**
 * ItemShoppingCartProductWidget.dart
 * 购物车商品项
 * @author: Ruoyegz
 * @date: 2021/7/2
 */
class ItemShoppingCartProductWidget extends StatefulWidget {
  /// 商铺信息
  final Shop shop;

  /// 商品信息
  final Product product;

  /// 商品操作
  final ProductOptionProvider provider;

  const ItemShoppingCartProductWidget(
      {Key? key,
      required this.shop,
      required this.product,
      required this.provider})
      : super(key: key);

  @override
  _ItemShoppingCartProductState createState() =>
      _ItemShoppingCartProductState(shop, product, provider);
}

class _ItemShoppingCartProductState
    extends State<ItemShoppingCartProductWidget> {
  /// 商铺信息
  final Shop shop;

  /// 商品信息
  final Product product;

  /// 商品操作
  final ProductOptionProvider provider;

  _ItemShoppingCartProductState(this.shop, this.product, this.provider);

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
      margin: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /// 购物车商品图片
          buildCartProductImage(),

          /// 购物车商品信息
          buildCartProductInfo(),

          /// 购物车商品加减操作
          buildProductOptions()
        ],
      ),
    );
  }

  /**
   * 购物车商品图片
   */
  ClipRRect buildCartProductImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: FadeInImage.assetNetwork(
        height: 60,
        width: 60,
        fit: BoxFit.cover,
        fadeInDuration: const Duration(milliseconds: 50),
            fadeOutDuration: const Duration(milliseconds: 50),
        placeholder: "packages/resources/res/images/def_cover_1_1.png",
        image: product.productImage(),
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset("res/images/def_cover_1_1.png", package: 'resources',);
        },
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
              margin: EdgeInsets.only(left: 10, right: 10),
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

  /**
   * 购物车商品加减操作
   */
  Container buildProductOptions() {
    return Container(
      alignment: Alignment.bottomRight,
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColor.colorF8,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
            ),
            child: IconButton(
                onPressed: () {
                  if (provider != null) {
                    provider.minusProduct(product, shop);
                  }
                },
                icon: Image.asset(
                  "res/icons/ic_option_minus.png",
                  package: 'resources',
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                )),
          ),
          Container(
              height: 24,
              width: 27,
              alignment: Alignment.center,
              padding: EdgeInsets.all(4),
              margin: EdgeInsets.only(left: 0.6, right: 0.6),
              decoration: BoxDecoration(
                color: AppColor.colorF8,
              ),
              child: Text(
                "${product.goodsNumber}",
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColor.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              )),
          Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.colorF8,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
              ),
              child: IconButton(
                  onPressed: () {
                    if (provider != null) {
                      provider.addProduct(product, shop);
                    }
                  },
                  icon: Image.asset(
                    "res/icons/ic_option_add.png",
                    package: 'resources',
                    width: 20,
                    height: 20,
                    fit: BoxFit.fill,
                  )))
        ],
      ),
    );
  }
}
