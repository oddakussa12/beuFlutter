
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shopping/src/actuator/product_option_provider.dart';

/**
 * item_my_bag_product.dart
 * 购物车商品下商品项
 * @author: Ruoyegz
 * @date: 2021/7/2
 */
class ItemOrderPreviewProductWidget extends StatefulWidget {
  final Shop shop;

  /// 商铺信息
  final Product product;
  final ProductOptionProvider provider;

  const ItemOrderPreviewProductWidget(
      {Key? key,
      required this.shop,
      required this.product,
      required this.provider})
      : super(key: key);

  @override
  _ItemOrderPreviewProductState createState() =>
      _ItemOrderPreviewProductState(shop, product, provider);
}

class _ItemOrderPreviewProductState
    extends State<ItemOrderPreviewProductWidget> {
  final Shop shop;
  final Product product;
  final ProductOptionProvider provider;

  _ItemOrderPreviewProductState(this.shop, this.product, this.provider);

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
   * 购物车商品选择
   */
  Widget buildCartProductCheck() {
    return Container(
      width: 20,
      height: 60,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Checkbox(
          value: product.isChecked,
          activeColor: AppColor.colorF7551D,
          onChanged: (checked) {
            product.isChecked = checked;
            if (checked! && !shop.isChecked!) {
              shop.isChecked = checked;
            }
            if (provider != null) {
              provider.checkShopProduct(shop, product);
            }
          }),
    );
  }

  /**
   * 购物车商品图片
   */
  Widget buildCartProductImage() {
    return Container(
      margin: EdgeInsets.only(left: 8, top: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: FadeInImage.assetNetwork(
          height: 60,
          width: 60,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 100),
          placeholder: "packages/resources/res/images/def_cover_1_1.png",
          image: product.productImage(),
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset("res/images/def_cover_1_1.png", package: "resources",);
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
              color: AppColor.white,
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
                  package: "resources",
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
              margin: EdgeInsets.only(left: 1, right: 1),
              decoration: BoxDecoration(
                color: AppColor.white,
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
              margin: EdgeInsets.only(right: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.white,
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
                    package: "resources",
                    width: 20,
                    height: 20,
                    fit: BoxFit.fill,
                  )))
        ],
      ),
    );
  }
}
