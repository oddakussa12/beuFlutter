import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

/**
 * ItemCommonProductBar
 * 通用的商品条目【图 + 价格 + 数量】
 * @author: Ruoyegz
 * @date: 2021/7/2
 */
class ItemCommonProductBar extends StatefulWidget {
  /// 商铺信息
  final Shop shop;

  /// 商铺信息
  final Product product;

  ItemCommonProductBar({Key? key, required this.shop, required this.product})
      : super(key: key);

  @override
  _ItemOrderPreviewProductState createState() =>
      _ItemOrderPreviewProductState();
}

class _ItemOrderPreviewProductState extends State<ItemCommonProductBar> {
  @override
  Widget build(BuildContext context) {
    if (widget.product == null) {
      return Container();
    }
    if (widget.product.isChecked == null) {
      widget.product.isChecked = false;
    }
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 4, right: 4, top: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /// 购物车商品图片
          buildProductImage(),

          /// 购物车商品信息
          buildProductPriceInfo(),

          /// 购物车商品数量
          buildProductNumber()
        ],
      ),
    );
  }

  /**
   * 购物车商品图片
   */
  Widget buildProductImage() {
    return Container(
        margin: EdgeInsets.only(left: 8, top: 4),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              fadeInDuration: const Duration(milliseconds: 50),
              fadeOutDuration: const Duration(milliseconds: 50),
              imageUrl: widget.product.productImage(),
              placeholder: (context, url) => Image.asset(
                  "res/images/def_cover_1_1.png",
                  package: 'resources',
                  fit: BoxFit.cover,
                  height: 64,
                  gaplessPlayback: true,
                  width: 64),
              errorWidget: (context, url, error) => Image.asset(
                  "res/images/def_cover_1_1.png",
                  package: 'resources',
                  fit: BoxFit.cover,
                  height: 64,
                  gaplessPlayback: true,
                  width: 64),
              height: 64,
              width: 64,
              fit: BoxFit.cover,
            )));
  }

  /**
   * 购物车商品信息
   */
  Widget buildProductPriceInfo() {
    return Expanded(
        child: Container(
      height: 64,
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              alignment: Alignment.topLeft,
              child: Text(
                TextHelper.clean(widget.product.name),
                maxLines: widget.product.isGFCategory() ? 1 : 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: AppColor.color0F0F17, fontSize: 14),
              )),

          /// 商品原价
          (widget.product.discountPrice ?? 0) > 0
              ? Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    TextHelper.clean(widget.product.discountPrice.toString() +
                        " " +
                        widget.product.currency.toString()),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: AppColor.colorBE,
                        fontSize: 16,
                        // decoration:  widget.product.discountPrice!>0
                        //     ? TextDecoration.lineThrough
                        //     : TextDecoration.none,
                        decorationThickness: 2),
                  ))
              : Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    TextHelper.clean(widget.product.formatPrice),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: AppColor.colorBE,
                        fontSize: 16,
                        // decoration:  widget.product.discountPrice!>0
                        //     ? TextDecoration.lineThrough
                        //     : TextDecoration.none,
                        decorationThickness: 2),
                  )),

          /// 官方分类下的商品展示折扣价

          Visibility(
            visible: widget.product.isGFCategory(),
            child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                alignment: Alignment.topLeft,
                child: Text(
                  TextHelper.clean(widget.product.formatDisPrice),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColor.colorBE, fontSize: 16),
                )),
          ),
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
        margin: EdgeInsets.only(left: 1, right: 1, bottom: 5),
        child: Text(
          "${widget.product.goodsNumber}",
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColor.black, fontSize: 16, fontWeight: FontWeight.bold),
        ));
  }
}
