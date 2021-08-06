import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shopping/src/actuator/product_option_provider.dart';

/**
 * ItemOrderPreviewProductWidget
 * 预览订单商品下商品项
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
          /// 订单商品图片
          buildOrderProductImage(),

          /// 订单商品信息
          buildOrderProductInfo(),

          /// 订单商品数量
          buildOrderProductNumber()
        ],
      ),
    );
  }

  /**
   * 订单商品图片
   */
  Widget buildOrderProductImage() {
    return Container(
      margin: EdgeInsets.only(left: 8, top: 4),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            fadeInDuration: const Duration(milliseconds: 100),
            imageUrl: TextHelper.clean(product.productImage()),
            placeholder: (context, url) => Image.asset(
              "res/images/def_cover_1_1.png",
              package: 'resources',
              fit: BoxFit.cover,
              height: 64,
              width: 64,
              gaplessPlayback: true,
            ),
            errorWidget: (context, url, error) => Image.asset(
              "res/images/def_cover_1_1.png",
              package: 'resources',
              fit: BoxFit.cover,
              height: 64,
              width: 64,
              gaplessPlayback: true,
            ),
            height: 64,
            width: 64,
            fit: BoxFit.cover,
          )),
    );
  }

  /**
   * 商品信息
   */
  Widget buildOrderProductInfo() {
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

          /// 原价
          Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              alignment: Alignment.topLeft,
              child: Text(
                TextHelper.clean(product.formatPrice),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: AppColor.colorBE,
                    fontSize: 16,
                    decorationThickness: 2,
                    decoration: product.specPrice != null && product.specPrice! > 0 ? TextDecoration.lineThrough : TextDecoration.none,
                    decorationStyle: TextDecorationStyle.solid),
              )),
          product.specPrice != null && product.specPrice! > 0
              ? Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "${ValueFormat.formatDouble(product.specPrice)}${product.currency}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: AppColor.colorBE, fontSize: 16),
                  ))
              : Container()
        ],
      ),
    ));
  }

  Widget buildOrderProductNumber() {
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
